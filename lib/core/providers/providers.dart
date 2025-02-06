// lib/core/providers/providers.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/repositories/auth_repository.dart';

// Firebase providers
final firebaseAuthProvider = Provider<FirebaseAuth>((ref) {
  throw UnimplementedError('Override this in main.dart');
});

final firestoreProvider = Provider<FirebaseFirestore>((ref) {
  throw UnimplementedError('Override this in main.dart');
});

// Repository providers
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  throw UnimplementedError('Override this in main.dart');
});
