import 'package:flutter/material.dart';
import 'package:spotify/spotify.dart';
import 'package:spotify_plus/helpers/get_service.dart';
import 'package:spotify_plus/services/api_services/tracks/tracks_service.dart';
import 'package:spotify_plus/widgets/common/spotify_widget.dart';
import 'package:spotify_plus/widgets/spotify/track/track_widget.dart';

class TopTracksDisplay extends StatelessWidget {
  const TopTracksDisplay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SpotifyWidget<List<Track>>(
      futureBuilder: () => getService<TracksService>().getUserTopTracks().then((data) => data.toList()),
      label: const Text('Your top tracks:'),
      width: 400,
      height: 400,
      builder: (context, tracks) => ListView.builder(
        itemCount: tracks.length,
        itemBuilder: (context, index) => TrackWidget(track: tracks[index]),
      ),
    );
  }
}