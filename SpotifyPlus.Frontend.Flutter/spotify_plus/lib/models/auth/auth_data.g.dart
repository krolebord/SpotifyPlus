// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthData _$AuthDataFromJson(Map<String, dynamic> json) {
  return AuthData(
    accessToken: json['accessToken'] as String,
    refreshToken: json['refreshToken'] as String,
    scopes: (json['scopes'] as List<dynamic>).map((e) => e as String).toList(),
    expiresAt: DateTime.parse(json['expiresAt'] as String),
  );
}

Map<String, dynamic> _$AuthDataToJson(AuthData instance) => <String, dynamic>{
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
      'scopes': instance.scopes,
      'expiresAt': instance.expiresAt.toIso8601String(),
    };
