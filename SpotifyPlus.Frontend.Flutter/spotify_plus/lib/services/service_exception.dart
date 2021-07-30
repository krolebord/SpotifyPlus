import 'package:flutter/foundation.dart';

@immutable
abstract class ServiceException {
  final String errorMessage;

  const ServiceException(this.errorMessage);

  @override
  String toString() {
    return '$runtimeType: $errorMessage';
  }
}
