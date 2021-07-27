import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:spotify_plus/api_urls.dart';
import 'package:spotify_plus/helpers/formatted_api_error_message.dart';
import 'package:spotify_plus/models/auth/auth_data.dart';
import 'package:spotify_plus/models/auth/auth_session.dart';
import 'package:spotify_plus/services/auth/auth_service.dart';
import 'package:spotify_plus/services/auth/auth_service_exception.dart';
import 'package:spotify_plus/services/auth_prefs/auth_prefs.dart';
import 'package:url_launcher/url_launcher.dart';

class AuthServiceImplementation implements AuthService {
  final AuthPrefs _authPrefs;
  final StreamController<AuthData?> _authChangedController;

  AuthData? _currentAuth;

  Future<AuthData>? _refreshFuture;

  AuthServiceImplementation() :
    _authPrefs = GetIt.instance.get<AuthPrefs>(),
    _authChangedController = StreamController<AuthData?>.broadcast()
  {
    _authChangedController.onListen = () => _authChangedController.add(_currentAuth);
    _loadAuth();
  }

  @override
  Stream<AuthData?> get authChanges => _authChangedController.stream;

  @override
  AuthData? get currentAuth => _currentAuth;

  @override
  Future<AuthData> signInWithSpotify() async {
    var client = Client();

    try {
      var url = Uri.parse(ApiUrls.getSpotifyAuth());
      var response = await client.get(url);

      if(response.statusCode != HttpStatus.ok) {
        throw AuthServiceException(errorMessage: formattedErrorMessage(
          reason: 'Response status is ${response.statusCode}',
          method: 'signInWithSpotify',
          endpoint: 'getSpotifyAuth'
        ));
      }

      var authSession = AuthSession.fromJson(jsonDecode(response.body));

      if(!await canLaunch(authSession.authUrl)) {
        throw AuthServiceException(errorMessage: formattedErrorMessage(
            reason: "Couldn't open auth url",
            method: 'signInWithSpotify',
            endpoint: 'getAuthData'
        ));
      }

      await launch(authSession.authUrl);

      url = Uri.parse(ApiUrls.getAuthData(authSession.authKey));
      response = await client.get(url);

      if(response.statusCode != HttpStatus.ok) {
        throw AuthServiceException(errorMessage: formattedErrorMessage(
            reason: 'Response status is ${response.statusCode}',
            method: 'signInWithSpotify',
            endpoint: 'getAuthData'
        ));
      }

      var authData = AuthData.fromJson(jsonDecode(response.body));

      _changeAuth(authData);

      return authData;
    }
    catch(e) {
      _changeAuth(null);
      rethrow;
    }
    finally {
      client.close();
    }
  }

  @override
  Future<AuthData> refreshAuth() {
    if(_refreshFuture != null) {
      return _refreshFuture!;
    }

    var authData = _currentAuth;

    if(authData == null) {
      throw AuthServiceException(errorMessage: formattedErrorMessage(
          reason: "Can't refresh auth data that is null",
          method: 'refreshAuth'
      ));
    }

    _refreshFuture = _handleAuthRefresh(authData);
    return _refreshFuture!;
  }

  Future<AuthData> _handleAuthRefresh(AuthData authData) async {
    var client = Client();

    try {
      var refreshToken = authData.refreshToken;
      var url = Uri.parse(ApiUrls.refreshAuthData(refreshToken));

      var response = await client.get(url);

      if(response.statusCode != HttpStatus.ok) {
        throw AuthServiceException(errorMessage: formattedErrorMessage(
            reason: 'Response status is ${response.statusCode}',
            method: 'refreshAuth',
            endpoint: 'getAuthData'
        ));
      }

      var refreshedAuthData = AuthData.fromJson(jsonDecode(response.body));
      refreshedAuthData = AuthData(
          refreshToken: refreshToken,
          accessToken: refreshedAuthData.accessToken,
          scopes: refreshedAuthData.scopes,
          expiresAt: refreshedAuthData.expiresAt
      );

      _changeAuth(refreshedAuthData);

      return refreshedAuthData;
    }
    catch(e) {
      _changeAuth(null);
      rethrow;
    }
    finally {
      client.close();
    }
  }

  @override
  Future<void> signOut() async {
    _changeAuth(null);
  }

  Future<void> _loadAuth() async {
    var loadedData = await _authPrefs.getAuthData();

    if(loadedData != null && _currentAuth == null) {
      _changeAuth(loadedData);
    }
  }

  void _changeAuth(AuthData? authData) {
    if(authData == _currentAuth) {
      return;
    }

    _currentAuth = authData;

    _authPrefs.setAuthData(_currentAuth);

    if(_authChangedController.hasListener) {
      _authChangedController.add(_currentAuth);
    }
  }
}