import 'package:oauth2/oauth2.dart';
import 'package:spotify/spotify.dart';
import 'package:spotify_plus/services/api_client_factory/api_client_factory.dart';
import 'package:spotify_plus/services/api_services/api_service.dart';

abstract class ApiServiceBase implements ApiService {
  @override
  final ApiClientFactory apiClientFactory;

  @override
  late final Future<SpotifyApi> spotifyFuture = apiClientFactory.getClient();

  @override
  late final Future<Client> clientFuture = spotifyFuture.then((value) => value.client);

  ApiServiceBase(this.apiClientFactory);
}
