import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/cupertino.dart';

part 'auth_session.g.dart';

@immutable
@JsonSerializable()
class AuthSession {
  final String authUrl;
  final String authKey;
  final DateTime expiresAt;

  const AuthSession({
    required this.authUrl,
    required this.authKey,
    required this.expiresAt
  });

  factory AuthSession.fromJson(Map<String, dynamic> json) => _$AuthSessionFromJson(json);
  Map<String, dynamic> toJson() => _$AuthSessionToJson(this);
}