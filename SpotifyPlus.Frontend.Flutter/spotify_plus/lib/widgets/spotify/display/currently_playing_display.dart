import 'package:flutter/material.dart';
import 'package:spotify/spotify.dart';
import 'package:spotify_plus/helpers/get_service.dart';
import 'package:spotify_plus/services/api_services/playback/playback_service.dart';
import 'package:spotify_plus/widgets/common/spotify_widget.dart';
import 'package:spotify_plus/widgets/spotify/track/track_widget.dart';

class CurrentlyPlayingDisplay extends StatelessWidget {
  const CurrentlyPlayingDisplay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SpotifyWidget<Player>(
      futureBuilder: getService<PlaybackService>().getCurrentPlayer,
      label: const Text('Currently playing:'),
      width: 400,
      height: 112,
      builder: (context, data) {
        return data.item != null
          ? TrackWidget(track: data.item!)
          : const Center(child: Text('Nothing'));
      },
    );
  }
}
