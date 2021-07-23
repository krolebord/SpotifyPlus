import 'package:shared_preferences/shared_preferences.dart';
import 'package:spotify_plus/models/auth/auth_data.dart';
import 'package:spotify_plus/services/authPrefs/auth_prefs.dart';

class AuthPrefsImplementation implements AuthPrefs {
  late SharedPreferences _prefs;

  @override
  Future<AuthData?> getAuthData() {
    // TODO: implement getAuthData
    throw UnimplementedError();
  }

  @override
  Future<bool> setAuthData() {
    // TODO: implement setAuthData
    throw UnimplementedError();
  }
}