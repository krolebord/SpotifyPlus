import 'package:spotify/spotify.dart';

abstract class ApiClientFactory {
  Future<SpotifyApi> getClient();
}