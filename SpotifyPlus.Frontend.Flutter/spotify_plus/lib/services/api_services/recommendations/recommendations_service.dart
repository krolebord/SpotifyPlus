import 'package:spotify/spotify.dart' hide RecommendationsSeed;
import 'package:spotify_plus/models/recommendations/recommendations_seed.dart';

import '../api_service.dart';

abstract class RecommendationsService implements ApiService {
  Future<Iterable<Track>> getSeeded(RecommendationsSeedData seed);
}
