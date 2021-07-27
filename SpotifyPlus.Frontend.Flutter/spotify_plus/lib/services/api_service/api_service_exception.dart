import 'package:flutter/material.dart';

@immutable
class ApiServiceException implements Exception {
  final String errorMessage;

  const ApiServiceException({required this.errorMessage});
}