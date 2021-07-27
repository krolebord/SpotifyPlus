import 'package:get_it/get_it.dart';
import 'package:spotify/spotify.dart';
import 'package:oauth2/oauth2.dart' as oauth;
import 'package:spotify_plus/helpers/formatted_api_error_message.dart';
import 'package:spotify_plus/services/api_credentials/api_credentials.dart';
import 'package:spotify_plus/services/api_client_factory/api_client_factory.dart';
import 'package:spotify_plus/services/api_client_factory/api_client_factory_exception.dart';
import 'package:spotify_plus/services/auth/auth_service.dart';

class ApiClientFactoryImplementation implements ApiClientFactory {
  final AuthService _authService = GetIt.instance.get<AuthService>();

  @override
  Future<SpotifyApi> getClient() async {
    if(_authService.currentAuth == null) {
      throw ApiClientFactoryException(errorMessage: formattedErrorMessage(
        reason: "Current auth data is null",
        method: "getClient"
      ));
    }

    var authData = _authService.currentAuth!;

    /*if(authData.expired) {
      authData = await _authService.refreshAuth();
    }

    var credentials = SpotifyApiCredentials(
      "", "",
      accessToken: authData.accessToken,
      refreshToken: authData.refreshToken,
      scopes: authData.scopes,
      expiration: authData.expiresAt
    );*/

    var client = oauth.Client(ApiCredentials.fromAuthData(authData));
    return SpotifyApi.fromClient(client);
  }
}