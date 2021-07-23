// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthData _$AuthDataFromJson(Map<String, dynamic> json) {
  return AuthData(
    accessToken: json['accessToken'] as String,
    tokenType: json['tokenType'] as String,
    scope: json['scope'] as String,
    expiresIn: json['expiresIn'] as int,
    refreshToken: json['refreshToken'] as String,
  );
}

Map<String, dynamic> _$AuthDataToJson(AuthData instance) => <String, dynamic>{
      'accessToken': instance.accessToken,
      'tokenType': instance.tokenType,
      'scope': instance.scope,
      'expiresIn': instance.expiresIn,
      'refreshToken': instance.refreshToken,
    };
