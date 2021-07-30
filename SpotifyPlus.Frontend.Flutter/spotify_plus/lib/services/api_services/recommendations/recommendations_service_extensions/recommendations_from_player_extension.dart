import 'package:spotify/spotify.dart';
import 'package:spotify_plus/helpers/get_service.dart';
import 'package:spotify_plus/models/recommendations/recommendations_seed.dart';
import 'package:spotify_plus/services/api_services/playback/playback_service.dart';
import 'package:spotify_plus/services/api_services/recommendations/recommendations_service.dart';
import 'package:spotify_plus/services/api_services/recommendations/recommendations_service_exception.dart';

extension RecommendationsFromPlayerExtension on RecommendationsService {
  Future<Iterable<Track>> getDefault() async {
    final seed = RecommendationsSeedData();

    final currentlyPlaying = await getService<PlaybackService>().getCurrentPlayer();

    if(currentlyPlaying.item == null) {
      throw const RecommendationsServiceException("No songs are currently playing");
    }

    var track = currentlyPlaying.item!;
    seed.tracks.add(track.id!);

    return getSeeded(seed);
  }
}
