import 'package:spotify_plus/models/auth/auth_data.dart';

abstract class AuthPrefs {
  Future<AuthData?> getAuthData();

  Future<bool> setAuthData(AuthData? authData);
}