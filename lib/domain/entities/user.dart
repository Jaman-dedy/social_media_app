import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';

@freezed
class User with _$User {
  const factory User({
    required String id,
    required String email,
    String? displayName,
    String? photoUrl,
    @Default(false) bool emailVerified,
    required DateTime createdAt,
    DateTime? lastLoginAt,
    @Default(false) bool isOnline,
    @Default([]) List<String> fcmTokens,
  }) = _User;

  const User._();

  String get initials {
    if (displayName?.isNotEmpty ?? false) {
      final nameParts = displayName!.split(' ');
      if (nameParts.length > 1) {
        return '${nameParts.first[0]}${nameParts.last[0]}'.toUpperCase();
      }
      return displayName![0].toUpperCase();
    }
    return email[0].toUpperCase();
  }
}
