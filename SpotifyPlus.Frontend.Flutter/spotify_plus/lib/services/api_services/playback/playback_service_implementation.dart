import 'package:injectable/injectable.dart';
import 'package:spotify/spotify.dart';
import 'package:spotify_plus/api_urls.dart';
import 'package:spotify_plus/services/api_client_factory/api_client_factory.dart';
import 'package:spotify_plus/services/api_services/api_service_base.dart';
import 'package:spotify_plus/services/api_services/playback/playback_service.dart';

@Singleton(as: PlaybackService)
class PlaybackServiceImplementation extends ApiServiceBase implements PlaybackService {
  PlaybackServiceImplementation(ApiClientFactory apiClientFactory) : super(apiClientFactory);

  @override
  Future<Player> getCurrentPlayer() async {
    return (await spotifyFuture).me.currentlyPlaying();
  }

  @override
  Future<void> playTrack(TrackSimple track) async {
    await addTrackToQueue(track);
    await trySkipCurrentTrack();
  }

  @override
  Future<void> addTrackToQueue(TrackSimple track) async {
    if(track.uri?.isEmpty == true) {
      return;
    }

    final client = await clientFuture;

    var url = Uri.parse(ApiUrls.spotify + "/v1/me/player/queue?uri=${track.uri}");
    await client.post(url);
  }

  @override
  Future<bool> trySkipCurrentTrack() async {
    final client = await clientFuture;

    var url = Uri.parse(ApiUrls.spotify + "/v1/me/player/next");
    var response = await client.post(url);

    return response.statusCode != 204;
  }
}
