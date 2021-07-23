// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_urls_object.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthUrlsObject _$AuthUrlsObjectFromJson(Map<String, dynamic> json) {
  return AuthUrlsObject(
    authUrl: json['authUrl'] as String,
    tokenUrl: json['tokenUrl'] as String,
    authKey: json['authKey'] as String,
  );
}

Map<String, dynamic> _$AuthUrlsObjectToJson(AuthUrlsObject instance) =>
    <String, dynamic>{
      'authUrl': instance.authUrl,
      'tokenUrl': instance.tokenUrl,
      'authKey': instance.authKey,
    };
