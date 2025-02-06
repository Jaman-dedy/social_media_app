// lib/presentation/providers/auth/auth_derived_providers.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'auth_state_provider.dart';
import 'package:flutter/foundation.dart';
import '../../../domain/entities/user.dart';
import '../../../domain/core/failures/auth_failure.dart';
import '../../../core/providers/providers.dart';

/// Stream of auth state changes
final authStateChangesProvider = StreamProvider((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return authRepository.authStateChanges;
});

/// Provider for checking if user is authenticated
final isAuthenticatedProvider = Provider<bool>((ref) {
  final authState = ref.watch(authStateProvider);
  debugPrint('Auth state changed: ${authState.toString()}');
  debugPrint('Is authenticated: ${authState.isAuthenticated}');
  return authState.isAuthenticated;
});

/// Provider for checking if email is verified
final isEmailVerifiedProvider = Provider<bool>((ref) {
  return ref.watch(authStateProvider).isEmailVerified;
});

/// Provider for current user
final currentUserProvider = Provider<User?>((ref) {
  return ref.watch(authStateProvider).user;
});

/// Provider for auth loading state
final authLoadingProvider = Provider<bool>((ref) {
  return ref.watch(authStateProvider).isLoading;
});

/// Provider for auth failure state
final authFailureProvider = Provider<AuthFailure?>((ref) {
  return ref.watch(authStateProvider).failure;
});
