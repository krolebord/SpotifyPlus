import 'package:injectable/injectable.dart';
import 'package:spotify/spotify.dart';
import 'package:spotify_plus/services/api_client_factory/api_client_factory.dart';
import 'package:spotify_plus/services/api_services/api_service_base.dart';
import 'package:spotify_plus/services/api_services/tracks/tracks_service.dart';

@Singleton(as: TracksService)
class TracksServiceImplementation extends ApiServiceBase implements TracksService {
  TracksServiceImplementation(ApiClientFactory apiClientFactory) : super(apiClientFactory);

  @override
  Future<Track> getTrack(String trackId) async {
    var spotify = await spotifyFuture;
    return spotify.tracks.get(trackId);
  }

  @override
  Future<Iterable<Track>> getTracks(Iterable<String> trackIds) async {
    var spotify = await spotifyFuture;
    return spotify.tracks.list(trackIds);
  }

  @override
  Future<AudioFeature> getTrackFeatures(String trackId) async {
    var spotify = await spotifyFuture;
    return spotify.audioFeatures.get(trackId);
  }

  @override
  Future<Iterable<Track>> getUserTopTracks() async {
    var spotify = await spotifyFuture;
    return spotify.me.topTracks();
  }
}
