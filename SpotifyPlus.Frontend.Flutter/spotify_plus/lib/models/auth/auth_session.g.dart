// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthUrlsObject _$AuthUrlsObjectFromJson(Map<String, dynamic> json) {
  return AuthUrlsObject(
    authUrl: json['authUrl'] as String,
    authKey: json['authKey'] as String,
    expiresAt: DateTime.parse(json['expiresAt'] as String),
  );
}

Map<String, dynamic> _$AuthUrlsObjectToJson(AuthUrlsObject instance) =>
    <String, dynamic>{
      'authUrl': instance.authUrl,
      'authKey': instance.authKey,
      'expiresAt': instance.expiresAt.toIso8601String(),
    };
