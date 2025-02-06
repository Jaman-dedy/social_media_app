// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserModelImpl _$$UserModelImplFromJson(Map<String, dynamic> json) =>
    _$UserModelImpl(
      id: json['id'] as String,
      email: json['email'] as String,
      displayName: json['display_name'] as String?,
      photoUrl: json['photo_url'] as String?,
      emailVerified: json['email_verified'] as bool? ?? false,
      createdAt: DateTime.parse(json['created_at'] as String),
      lastLoginAt: json['last_login_at'] == null
          ? null
          : DateTime.parse(json['last_login_at'] as String),
      isOnline: json['is_online'] as bool? ?? false,
      fcmTokens: (json['fcm_tokens'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      if (instance.displayName case final value?) 'display_name': value,
      if (instance.photoUrl case final value?) 'photo_url': value,
      'email_verified': instance.emailVerified,
      'created_at': instance.createdAt.toIso8601String(),
      if (instance.lastLoginAt?.toIso8601String() case final value?)
        'last_login_at': value,
      'is_online': instance.isOnline,
      'fcm_tokens': instance.fcmTokens,
    };
