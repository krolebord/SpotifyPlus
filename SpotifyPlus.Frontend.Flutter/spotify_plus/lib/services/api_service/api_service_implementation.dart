import 'dart:math';
import 'package:get_it/get_it.dart';
import 'package:oauth2/oauth2.dart' as oauth;
import 'package:spotify/spotify.dart';
import 'package:spotify_plus/api_urls.dart';
import 'package:spotify_plus/services/api_client_factory/api_client_factory.dart';
import 'package:spotify_plus/services/api_service/api_service.dart';
import 'package:spotify_plus/services/api_service/api_service_exception.dart';

class ApiServiceImplementation implements ApiService {
  final ApiClientFactory _apiClientFactory = GetIt.instance.get<ApiClientFactory>();


  late final Future<SpotifyApi> _spotify = _apiClientFactory.getClient();
  late final Future<oauth.Client> _client = _spotify.then((value) => value.client);

  @override
  Future<Player> getCurrentlyPlaying() async {
    return (await _spotify).me.currentlyPlaying();
  }

  @override
  Future<List<Track>> getTracks(Iterable<String> trackIds) async {
    final spotify = await _spotify;
    return (await spotify.tracks.list(trackIds)).toList();
  }
  
  @override
  Future<List<Track>> getTopTracks() async {
    final trackIterable = await (await _spotify).me.topTracks();
    return trackIterable.toList();
  }

  @override
  Future<List<Track>> getRecommendations() async {
    final spotify = await _spotify;

    final rng = Random();

    final topTracks = (await spotify.me.topTracks()).toList();

    List<String> seedTracks = [];
    for(int i = 0; i < 3; ++i) {
      var trackIndex = rng.nextInt(topTracks.length);
      var track = topTracks.removeAt(trackIndex);
      seedTracks.add(track.id!);
    }

    final topArtists = (await spotify.me.topArtists()).toList();

    List<String> seedArtists = [];
    List<String> seedGenres = [];
    for(int i = 0; i < 1; ++i) {
      var artistIndex = rng.nextInt(topArtists.length);
      var artist = topArtists.removeAt(artistIndex);
      seedArtists.add(artist.id!);

      var genreIndex = rng.nextInt(artist.genres!.length);
      seedGenres.add(artist.genres![genreIndex]);
    }

    var recommendations = await spotify.recommendations.get(
      seedTracks: seedTracks,
      seedArtists: [],
      seedGenres: [],
      market: 'UA',
      target: {},
      min: {},
      max: {}
    );

    var trackIds = recommendations.tracks!.map((track) => track.id!);
    return await getTracks(trackIds);
  }

  @override
  Future<AudioFeature> getTrackFeatures(String trackId) async {
    return (await _spotify).audioFeatures.get(trackId);
  }
  
  @override
  Future<void> playTrack(TrackSimple track) async {
    await addTrackToQueue(track);
    await skipCurrentTrack();
  }

  @override
  Future<void> skipCurrentTrack() async {
    final client = await _client;

    var url = Uri.parse(ApiUrls.spotify + "/v1/me/player/next");
    var response = await client.post(url);

    if(response.statusCode != 204) {
      throw const ApiServiceException(errorMessage: "Couldn't skip track");
    }
  }

  @override
  Future<void> addTrackToQueue(TrackSimple track) async {
    if(track.uri?.isEmpty == true) {
      return;
    }

    final client = await _client;

    var url = Uri.parse(ApiUrls.spotify + "/v1/me/player/queue?uri=${track.uri}");
    await client.post(url);
  }
}