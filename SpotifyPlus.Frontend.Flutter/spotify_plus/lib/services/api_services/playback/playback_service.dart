import 'package:spotify/spotify.dart';

import '../api_service.dart';

abstract class PlaybackService implements ApiService {
  Future<Player> getCurrentPlayer();

  Future<void> playTrack(TrackSimple track);

  Future<bool> trySkipCurrentTrack();

  Future<void> addTrackToQueue(TrackSimple track);
}
