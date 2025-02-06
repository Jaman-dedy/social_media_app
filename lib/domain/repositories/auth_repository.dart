// lib/domain/repositories/auth_repository.dart
import 'package:fpdart/fpdart.dart';
import '../entities/user.dart';
import '../core/failures/auth_failure.dart';

abstract class AuthRepository {
  Stream<Option<User>> get authStateChanges;

  Option<User> get currentUser;

  Future<Either<AuthFailure, User>> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<Either<AuthFailure, User>> signUpWithEmailAndPassword({
    required String email,
    required String password,
    String? displayName,
  });

  Future<Either<AuthFailure, Unit>> sendPasswordResetEmail(String email);

  Future<Either<AuthFailure, Unit>> sendEmailVerification();

  Future<Option<Unit>> signOut();
}
