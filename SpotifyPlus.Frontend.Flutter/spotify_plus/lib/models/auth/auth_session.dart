import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/cupertino.dart';

part 'auth_session.g.dart';

@immutable
@JsonSerializable()
class AuthUrlsObject {
  final String authUrl;
  final String authKey;
  final DateTime expiresAt;

  const AuthUrlsObject({
    required this.authUrl,
    required this.authKey,
    required this.expiresAt
  });

  factory AuthUrlsObject.fromJson(Map<String, dynamic> json) => _$AuthUrlsObjectFromJson(json);
  Map<String, dynamic> toJson( instance) => _$AuthUrlsObjectToJson(this);
}