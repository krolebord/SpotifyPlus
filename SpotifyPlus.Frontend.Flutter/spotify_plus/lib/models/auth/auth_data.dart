import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/cupertino.dart';

part 'auth_data.g.dart';

@immutable
@JsonSerializable()
class AuthData extends Equatable {
  final String accessToken;
  final String refreshToken;
  final List<String> scopes;
  final DateTime expiresAt;

  const AuthData({
    required this.accessToken,
    required this.refreshToken,
    required this.scopes,
    required this.expiresAt,
  });

  @override
  List<Object> get props => [accessToken, refreshToken, scopes, expiresAt];

  factory AuthData.fromJson(Map<String, dynamic> json) => _$AuthDataFromJson(json);
  Map<String, dynamic> toJson() => _$AuthDataToJson(this);
}