import 'package:spotify/spotify.dart';

abstract class ApiService {
  Future<Player> getCurrentlyPlaying();

  Future<List<Track>> getTracks(Iterable<String> trackIds);

  Future<List<Track>> getTopTracks();

  Future<List<Track>> getRecommendations();

  Future<AudioFeature> getTrackFeatures(String trackId);

  Future<void> playTrack(TrackSimple track);

  Future<void> skipCurrentTrack();

  Future<void> addTrackToQueue(TrackSimple track);
}