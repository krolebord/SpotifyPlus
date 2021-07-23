import 'package:get_it/get_it.dart';
import 'package:spotify_plus/services/auth/auth_service.dart';
import 'package:spotify_plus/services/auth/auth_service_implementation.dart';

Future<void> registerServices() async {
  var services = GetIt.instance;

  services.registerSingleton<AuthService>(AuthServiceImplementation());

  return services.allReady();
}