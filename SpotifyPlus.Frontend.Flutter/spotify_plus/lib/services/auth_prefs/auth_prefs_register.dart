import 'package:get_it/get_it.dart';
import 'package:spotify_plus/services/auth_prefs/auth_prefs.dart';
import 'package:spotify_plus/services/auth_prefs/auth_prefs_implementation.dart';

extension AuthPrefsRegister on GetIt {
  void registerAuthPrefs() {
    registerSingleton<AuthPrefs>(AuthPrefsImplementation());
  }
}