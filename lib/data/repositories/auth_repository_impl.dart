// lib/data/repositories/auth_repository_impl.dart
import 'package:injectable/injectable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/entities/user.dart';
import '../../domain/core/failures/auth_failure.dart';
import '../models/user_model.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final firebase.FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  AuthRepositoryImpl(this._firebaseAuth, this._firestore);

  @override
  Option<User> get currentUser {
    final firebaseUser = _firebaseAuth.currentUser;
    if (firebaseUser == null) return none();
    return some(UserModel.fromFirebase(firebaseUser).toDomain());
  }

  @override
  Stream<Option<User>> get authStateChanges {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      if (firebaseUser == null) return none();
      return some(UserModel.fromFirebase(firebaseUser).toDomain());
    });
  }

  @override
  Future<Either<AuthFailure, User>> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user == null) {
        return left(const AuthFailure.serverError());
      }

      // Ensure user exists in Firestore and get complete user data
      final user = await _ensureUserDocument(userCredential.user!);
      return right(user);
    } on firebase.FirebaseAuthException catch (e) {
      return left(AuthFailure.fromFirebaseAuthException(e));
    } catch (_) {
      return left(const AuthFailure.serverError());
    }
  }

  @override
  Future<Either<AuthFailure, User>> signUpWithEmailAndPassword({
    required String email,
    required String password,
    String? displayName,
  }) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user == null) {
        return left(const AuthFailure.serverError());
      }

      if (displayName != null) {
        await userCredential.user!.updateDisplayName(displayName);
      }

      // Create user document in Firestore and get complete user data
      final user = await _createUserDocument(
        userCredential.user!,
        displayName,
      );

      return right(user);
    } on firebase.FirebaseAuthException catch (e) {
      return left(AuthFailure.fromFirebaseAuthException(e));
    } catch (_) {
      return left(const AuthFailure.serverError());
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> sendPasswordResetEmail(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      return right(unit);
    } on firebase.FirebaseAuthException catch (e) {
      return left(AuthFailure.fromFirebaseAuthException(e));
    } catch (_) {
      return left(const AuthFailure.serverError());
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> sendEmailVerification() async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user == null) {
        return left(const AuthFailure.userNotFound());
      }

      await user.sendEmailVerification();
      return right(unit);
    } on firebase.FirebaseAuthException catch (e) {
      return left(AuthFailure.fromFirebaseAuthException(e));
    } catch (_) {
      return left(const AuthFailure.serverError());
    }
  }

  @override
  Future<Option<Unit>> signOut() async {
    try {
      final uid = _firebaseAuth.currentUser?.uid;
      if (uid != null) {
        // Update online status
        await _firestore.collection('users').doc(uid).update({
          'isOnline': false,
          'lastSeenAt': FieldValue.serverTimestamp(),
        });
      }
      await _firebaseAuth.signOut();
      return some(unit);
    } catch (_) {
      return none();
    }
  }

  // Helper methods
  Future<User> _createUserDocument(
    firebase.User firebaseUser,
    String? displayName,
  ) async {
    try {
      debugPrint('Creating user document for uid: ${firebaseUser.uid}');
      final userDoc = _firestore.collection('users').doc(firebaseUser.uid);

      final userModel = UserModel(
        id: firebaseUser.uid,
        email: firebaseUser.email!,
        displayName: displayName ?? firebaseUser.email!.split('@').first,
        photoUrl: firebaseUser.photoURL,
        emailVerified: firebaseUser.emailVerified,
        createdAt: DateTime.now(),
        lastLoginAt: DateTime.now(),
        isOnline: true,
      );

      final firestoreData = userModel.toFirestore();
      debugPrint('Attempting to write user data: $firestoreData');

      await userDoc.set(firestoreData);
      debugPrint('User document created successfully');

      return userModel.toDomain();
    } catch (e, stackTrace) {
      debugPrint('Error creating user document: $e');
      debugPrint('Stack trace: $stackTrace');
      rethrow;
    }
  }

  Future<User> _ensureUserDocument(firebase.User firebaseUser) async {
    try {
      debugPrint('Ensuring user document exists for uid: ${firebaseUser.uid}');
      final userDoc = _firestore.collection('users').doc(firebaseUser.uid);
      final userSnapshot = await userDoc.get();

      if (!userSnapshot.exists) {
        debugPrint('User document does not exist, creating new one');
        return _createUserDocument(firebaseUser, firebaseUser.displayName);
      }

      debugPrint('Updating existing user document');
      // Update last login and online status
      await userDoc.update({
        'lastLoginAt': FieldValue.serverTimestamp(),
        'isOnline': true,
      });

      return UserModel.fromFirestore(
        userSnapshot as DocumentSnapshot<Map<String, dynamic>>,
        firebaseUser,
      ).toDomain();
    } catch (e, stackTrace) {
      debugPrint('Error in _ensureUserDocument: $e');
      debugPrint('Stack trace: $stackTrace');
      rethrow;
    }
  }
}
