import 'package:injectable/injectable.dart';
import 'package:spotify/spotify.dart';
import 'package:spotify_plus/models/recommendations/recommendations_seed.dart';
import 'package:spotify_plus/services/api_client_factory/api_client_factory.dart';
import 'package:spotify_plus/services/api_services/api_service_base.dart';
import 'package:spotify_plus/services/api_services/recommendations/recommendations_service.dart';
import 'package:spotify_plus/services/api_services/tracks/tracks_service.dart';

@Singleton(as: RecommendationsService)
class RecommendationsServiceImplementation extends ApiServiceBase implements RecommendationsService {
  final TracksService tracksService;

  RecommendationsServiceImplementation(
    ApiClientFactory apiClientFactory,
    this.tracksService
  ) : super(apiClientFactory);

  @override
  Future<Iterable<Track>> getSeeded(RecommendationsSeedData seed) async {
    var spotify = await spotifyFuture;

    var recommendations = await spotify.recommendations.get(
        seedTracks: seed.tracks,
        seedArtists: seed.artists,
        seedGenres: seed.genres,
        market: 'UA',
        target: {},
        min: {},
        max: {}
    );

    var trackIds = recommendations.tracks!.map((track) => track.id!);
    return tracksService.getTracks(trackIds);
  }
}
