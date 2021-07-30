class RecommendationsSeedData {
  final List<String> tracks;
  final List<String> artists;
  final List<String> genres;

  RecommendationsSeedData({
    List<String>? tracks,
    List<String>? artists,
    List<String>? genres
  }) :  tracks = tracks ?? [],
        artists = artists ?? [],
        genres = genres ?? [];
}
