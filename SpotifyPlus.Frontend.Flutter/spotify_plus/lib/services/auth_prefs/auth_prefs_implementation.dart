import 'dart:convert';

import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spotify_plus/models/auth/auth_data.dart';
import 'package:spotify_plus/services/auth_prefs/auth_prefs.dart';

class AuthPrefsImplementation implements AuthPrefs {
  static const String _authDataKey = "Auth_Data";

  late Future<void> _initializationFuture;
  late SharedPreferences _prefs;

  AuthData? _loadedData;

  AuthPrefsImplementation() {
    _initializationFuture = _initialize();
  }


  Future<void> _initialize() async {
    _prefs = await SharedPreferences.getInstance();

    try {
      if (_prefs.containsKey(_authDataKey)) {
        _loadedData =
            AuthData.fromJson(jsonDecode(_prefs.getString(_authDataKey)!));
      }
    }
    catch(e) {
      _loadedData = null;
      _prefs.remove(_authDataKey);
      Logger().log(Level.warning, "Couldn't load authData");
    }
  }

  @override
  Future<AuthData?> getAuthData() async {
    await _initializationFuture;

    return _loadedData;
  }

  @override
  Future<bool> setAuthData(AuthData? authData) async {
    await _initializationFuture;

    return authData != null
      ? _prefs.setString(_authDataKey, jsonEncode(authData.toJson()))
      : _prefs.remove(_authDataKey);
  }
}