// lib/presentation/providers/auth/auth_state_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import '../../../domain/entities/user.dart';
import '../../../domain/repositories/auth_repository.dart';
import '../../../domain/core/failures/auth_failure.dart';
import '../../../core/providers/providers.dart';

part 'auth_state_provider.freezed.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState({
    User? user,
    @Default(false) bool isLoading,
    AuthFailure? failure,
  }) = _AuthState;

  const AuthState._();

  bool get isAuthenticated {
    debugPrint('Checking isAuthenticated - user: $user');
    return user != null;
  }

  bool get isEmailVerified => user?.emailVerified ?? false;
}

final authStateProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(ref.watch(authRepositoryProvider));
});

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository _authRepository;

  AuthNotifier(this._authRepository) : super(const AuthState()) {
    _init();
  }

  void _init() {
    _authRepository.authStateChanges.listen((optionUser) {
      state = state.copyWith(
        user: optionUser.toNullable(),
        failure: null,
      );
    });
  }

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    debugPrint('AuthNotifier: Starting sign in');
    state = state.copyWith(isLoading: true, failure: null);

    final result = await _authRepository.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    result.fold(
      (failure) {
        debugPrint('AuthNotifier: Sign in failed - $failure');
        state = state.copyWith(failure: failure, isLoading: false);
      },
      (user) {
        debugPrint('AuthNotifier: Sign in successful - user: $user');
        state = state.copyWith(user: user, isLoading: false);
      },
    );
  }

  Future<void> signUpWithEmailAndPassword({
    required String email,
    required String password,
    String? displayName,
  }) async {
    state = state.copyWith(isLoading: true, failure: null);

    final result = await _authRepository.signUpWithEmailAndPassword(
      email: email,
      password: password,
      displayName: displayName,
    );

    result.fold(
      (failure) => state = state.copyWith(failure: failure, isLoading: false),
      (user) => state = state.copyWith(user: user, isLoading: false),
    );
  }

  Future<void> sendPasswordResetEmail(String email) async {
    state = state.copyWith(isLoading: true, failure: null);

    final result = await _authRepository.sendPasswordResetEmail(email);

    state = state.copyWith(
      isLoading: false,
      failure: result.fold((l) => l, (r) => null),
    );
  }

  Future<void> sendEmailVerification() async {
    state = state.copyWith(isLoading: true, failure: null);

    final result = await _authRepository.sendEmailVerification();

    state = state.copyWith(
      isLoading: false,
      failure: result.fold((l) => l, (r) => null),
    );
  }

  Future<void> signOut() async {
    state = state.copyWith(isLoading: true);
    await _authRepository.signOut();
    state = const AuthState();
  }

  Option<User> get currentUser => _authRepository.currentUser;
}
