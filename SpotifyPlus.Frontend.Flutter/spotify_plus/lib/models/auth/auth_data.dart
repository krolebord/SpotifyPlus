import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/cupertino.dart';

part 'auth_data.g.dart';

@immutable
@JsonSerializable()
class AuthData {
  final String accessToken;
  final String tokenType;
  final String scope;
  final int expiresIn;
  final String refreshToken;

  const AuthData({
    required this.accessToken,
    required this.tokenType,
    required this.scope,
    required this.expiresIn,
    required this.refreshToken,
  });

  factory AuthData.fromJson(Map<String, dynamic> json) => _$AuthDataFromJson(json);
  Map<String, dynamic> toJson( instance) => _$AuthDataToJson(this);
}