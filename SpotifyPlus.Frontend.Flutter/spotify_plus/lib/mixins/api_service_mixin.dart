import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:spotify_plus/services/api_service/api_service.dart';

mixin ApiServiceMixin on Widget {
  ApiService get apiService => GetIt.instance.get<ApiService>();
}