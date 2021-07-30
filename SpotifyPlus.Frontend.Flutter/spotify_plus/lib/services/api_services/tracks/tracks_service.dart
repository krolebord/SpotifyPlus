import 'package:spotify/spotify.dart';
import 'package:spotify_plus/services/api_services/api_service.dart';

abstract class TracksService implements ApiService {
  Future<Track> getTrack(String id);

  Future<Iterable<Track>> getTracks(Iterable<String> trackIds);

  Future<AudioFeature> getTrackFeatures(String trackId);

  Future<Iterable<Track>> getUserTopTracks();
}
