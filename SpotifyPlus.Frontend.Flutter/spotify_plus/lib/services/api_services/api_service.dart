import 'package:oauth2/oauth2.dart';
import 'package:spotify/spotify.dart';
import 'package:spotify_plus/services/api_client_factory/api_client_factory.dart';

abstract class ApiService {
  abstract final ApiClientFactory apiClientFactory;

  abstract final Future<SpotifyApi> spotifyFuture;

  abstract final Future<Client> clientFuture;
}
