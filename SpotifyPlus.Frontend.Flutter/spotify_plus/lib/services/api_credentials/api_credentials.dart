import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:oauth2/oauth2.dart' as oauth;
import 'package:spotify_plus/models/auth/auth_data.dart';
import 'package:spotify_plus/services/auth/auth_service.dart';

class ApiCredentials extends oauth.Credentials {
  final AuthService _authService = GetIt.instance.get<AuthService>();

  ApiCredentials.fromAuthData(AuthData authData) :
    super(
      authData.accessToken,
      scopes: authData.scopes,
      expiration: authData.expiresAt
    );

  @override
  bool get canRefresh => _authService.currentAuth != null;

  @override
  Future<oauth.Credentials> refresh(
    {String? identifier,
    String? secret,
    Iterable<String>? newScopes,
    bool basicAuth = true,
    http.Client? httpClient
  }) async {
    var refreshedData = await _authService.refreshAuth();
    return ApiCredentials.fromAuthData(refreshedData);
  }
}