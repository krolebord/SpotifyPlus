import 'package:get_it/get_it.dart';
import 'package:spotify_plus/services/api_client_factory/api_client_factory_register.dart';
import 'package:spotify_plus/services/api_service/api_service_register.dart';
import 'package:spotify_plus/services/auth/auth_service_register.dart';
import 'package:spotify_plus/services/auth_prefs/auth_prefs_register.dart';

Future<void> registerServices() async {
  GetIt services = GetIt.instance;

  services.registerAuthPrefs();

  services.registerAuthService();

  services.registerApiClientFactory();

  services.registerApiService();

  return services.allReady();
}