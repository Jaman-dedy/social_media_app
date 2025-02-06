// lib/domain/core/failures/auth_failure.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_failure.freezed.dart';

@freezed
class AuthFailure with _$AuthFailure {
  const AuthFailure._();

  const factory AuthFailure.cancelledByUser() = _CancelledByUser;
  const factory AuthFailure.serverError() = _ServerError;
  const factory AuthFailure.emailAlreadyInUse() = _EmailAlreadyInUse;
  const factory AuthFailure.invalidEmail() = _InvalidEmail;
  const factory AuthFailure.weakPassword() = _WeakPassword;
  const factory AuthFailure.userNotFound() = _UserNotFound;
  const factory AuthFailure.wrongPassword() = _WrongPassword;
  const factory AuthFailure.userDisabled() = _UserDisabled;
  const factory AuthFailure.tooManyRequests() = _TooManyRequests;
  const factory AuthFailure.operationNotAllowed() = _OperationNotAllowed;
  const factory AuthFailure.emailNotVerified() = _EmailNotVerified;
  const factory AuthFailure.networkError() = _NetworkError;
  const factory AuthFailure.unexpectedError() = _UnexpectedError;

  String get message {
    return when(
      cancelledByUser: () => 'Authentication was cancelled by user',
      serverError: () => 'An error occurred on our end. Please try again later',
      emailAlreadyInUse: () =>
          'This email is already registered. Please use a different email or try signing in',
      invalidEmail: () => 'Please enter a valid email address',
      weakPassword: () =>
          'The password provided is too weak. Please use a stronger password',
      userNotFound: () =>
          'No user found with this email. Please check your email or sign up',
      wrongPassword: () => 'Incorrect password. Please try again',
      userDisabled: () =>
          'This account has been disabled. Please contact support',
      tooManyRequests: () => 'Too many attempts. Please try again later',
      operationNotAllowed: () =>
          'This operation is not allowed. Please contact support',
      emailNotVerified: () => 'Please verify your email before signing in',
      networkError: () =>
          'A network error occurred. Please check your connection',
      unexpectedError: () => 'An unexpected error occurred. Please try again',
    );
  }

  /// Factory constructor to create AuthFailure from FirebaseAuthException
  factory AuthFailure.fromFirebaseAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'email-already-in-use':
        return const AuthFailure.emailAlreadyInUse();
      case 'invalid-email':
        return const AuthFailure.invalidEmail();
      case 'weak-password':
        return const AuthFailure.weakPassword();
      case 'user-not-found':
        return const AuthFailure.userNotFound();
      case 'wrong-password':
        return const AuthFailure.wrongPassword();
      case 'user-disabled':
        return const AuthFailure.userDisabled();
      case 'operation-not-allowed':
        return const AuthFailure.operationNotAllowed();
      case 'too-many-requests':
        return const AuthFailure.tooManyRequests();
      case 'network-request-failed':
        return const AuthFailure.networkError();
      default:
        return const AuthFailure.unexpectedError();
    }
  }
}
