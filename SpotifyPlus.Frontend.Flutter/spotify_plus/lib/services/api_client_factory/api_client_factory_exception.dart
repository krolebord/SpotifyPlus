import 'package:flutter/material.dart';

@immutable
class ApiClientFactoryException {
  final String errorMessage;

  const ApiClientFactoryException({required this.errorMessage});
}