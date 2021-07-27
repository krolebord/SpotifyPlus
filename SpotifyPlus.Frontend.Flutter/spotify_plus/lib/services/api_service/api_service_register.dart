import 'package:get_it/get_it.dart';
import 'package:spotify_plus/services/api_service/api_service.dart';
import 'package:spotify_plus/services/api_service/api_service_implementation.dart';

extension ApiServiceRegister on GetIt {
  void registerApiService() {
    registerSingleton<ApiService>(ApiServiceImplementation());
  }
}