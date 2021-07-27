import 'package:flutter/material.dart';
import 'package:spotify/spotify.dart';
import 'package:spotify_plus/mixins/api_service_mixin.dart';
import 'package:spotify_plus/widgets/common/safe_future_builder.dart';
import 'package:spotify_plus/widgets/spotify/track/track_features_widget.dart';
import 'package:spotify_plus/widgets/spotify/track/track_widget.dart';

class TrackDetailedWidget extends StatelessWidget with ApiServiceMixin {
  final Track track;

  const TrackDetailedWidget({
    required this.track,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text('Track details'),
        TrackWidget(track: track),
        _buildDetails()
      ],
    );
  }

  Widget _buildDetails() {
    return SafeFutureBuilder<AudioFeature>(
      futureBuilder: () => apiService.getTrackFeatures(track.id!),
      dataBuilder: _buildData,
    );
  }

  Widget _buildData(BuildContext context, AudioFeature features) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: TrackFeaturesWidget(features: features),
    );
  }
}
