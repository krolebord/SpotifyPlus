import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/cupertino.dart';

part 'auth_urls_object.g.dart';

@immutable
@JsonSerializable()
class AuthUrlsObject {
  final String authUrl;
  final String tokenUrl;
  final String authKey;

  const AuthUrlsObject({
    required this.authUrl,
    required this.tokenUrl,
    required this.authKey
  });

  factory AuthUrlsObject.fromJson(Map<String, dynamic> json) => _$AuthUrlsObjectFromJson(json);
  Map<String, dynamic> toJson( instance) => _$AuthUrlsObjectToJson(this);
}