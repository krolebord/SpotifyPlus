import 'package:get_it/get_it.dart';
import 'package:spotify_plus/services/auth/auth_service.dart';
import 'package:spotify_plus/services/auth/auth_service_implementation.dart';

extension AuthServiceRegister on GetIt {
  void registerAuthService() {
    registerSingleton<AuthService>(AuthServiceImplementation());
  }
}