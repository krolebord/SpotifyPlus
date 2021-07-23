import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:spotify_plus/api_urls.dart';
import 'package:spotify_plus/helpers/formatted_api_error_message.dart';
import 'package:spotify_plus/models/auth/auth_data.dart';
import 'package:spotify_plus/models/auth/auth_urls_object.dart';
import 'package:spotify_plus/services/auth/auth_service.dart';
import 'package:spotify_plus/services/auth/auth_service_error.dart';
import 'package:spotify_plus/services/auth/auth_service_exception.dart';
import 'package:url_launcher/url_launcher.dart';

class AuthServiceImplementation implements AuthService {
  final StreamController<AuthData?> _userChangedController;

  AuthData? _currentAuth;

  AuthServiceImplementation() :
    _userChangedController = StreamController<AuthData?>.broadcast() {
    _userChangedController.onListen = () => _userChangedController.add(_currentAuth);
  }

  @override
  Stream<AuthData?> get authChanges => _userChangedController.stream;

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

      var authUrls = AuthUrlsObject.fromJson(jsonDecode(response.body));

      if(!await canLaunch(authUrls.authUrl)) {
        throw AuthServiceError();
      }

      await launch(authUrls.authUrl);

      url = Uri.parse(ApiUrls.getAuthData(authUrls.authKey));
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

  void _changeAuth(AuthData? authData) {
    _currentAuth = authData;

    if(_userChangedController.hasListener) {
      _userChangedController.add(_currentAuth);
    }
  }
}