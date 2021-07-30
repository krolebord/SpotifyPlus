import 'package:flutter/material.dart';
import 'package:spotify/spotify.dart';
import 'package:spotify_plus/helpers/get_service.dart';
import 'package:spotify_plus/services/api_services/recommendations/recommendations_service.dart';
import 'package:spotify_plus/services/api_services/recommendations/recommendations_service_extensions/recommendations_from_player_extension.dart';
import 'package:spotify_plus/widgets/common/spotify_widget.dart';
import 'package:spotify_plus/widgets/spotify/track/track_widget.dart';

class RecommendationsDisplay extends StatefulWidget {
  const RecommendationsDisplay({Key? key}) : super(key: key);

  @override
  State<RecommendationsDisplay> createState() => _RecommendationsDisplayState();
}

class _RecommendationsDisplayState extends State<RecommendationsDisplay> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SpotifyWidget<List<Track>>(
      futureBuilder: () => getService<RecommendationsService>().getDefault().then((data) => data.toList()),
      label: const Text('Recommendations:'),
      width: 600,
      height: 400,
      builder: (context, tracks) => ListView.builder(
        controller: _scrollController,
        itemCount: tracks.length,
        itemBuilder: (context, index) => TrackWidget(track: tracks[index]),
      ),
    );
  }
}