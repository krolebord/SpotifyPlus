// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthSession _$AuthSessionFromJson(Map<String, dynamic> json) {
  return AuthSession(
    authUrl: json['authUrl'] as String,
    authKey: json['authKey'] as String,
    expiresAt: DateTime.parse(json['expiresAt'] as String),
  );
}

Map<String, dynamic> _$AuthSessionToJson(AuthSession instance) =>
    <String, dynamic>{
      'authUrl': instance.authUrl,
      'authKey': instance.authKey,
      'expiresAt': instance.expiresAt.toIso8601String(),
    };
