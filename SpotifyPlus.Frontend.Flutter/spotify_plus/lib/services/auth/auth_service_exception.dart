import 'package:flutter/material.dart';

@immutable
class AuthServiceException implements Exception {
  final String errorMessage;

  const AuthServiceException({required this.errorMessage});
}