import 'package:flutter/material.dart';
import 'package:spotify/spotify.dart';

class TrackFeaturesWidget extends StatelessWidget {
  final AudioFeature features;

  const TrackFeaturesWidget({
    required this.features,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildRow('Acousticness:', features.acousticness._toPercent),
        _buildRow('Instrumentalness:', features.instrumentalness._toPercent),
        _buildRow('Liveness:', features.liveness._toPercent),
        _buildRow('Valence:', features.valence._toPercent),
        _buildRow('Danceability:', features.danceability._toPercent),
        _buildRow('Energy:', features.energy._toPercent),
        _buildRow('Speechiness:', features.speechiness._toPercent),
        _buildRow('Average loudness:', features.loudness != null ? '${features.loudness} db' : null),
        _buildRow('Average tempo:', features.tempo != null ? '${features.tempo!.round()} bpm' : null),
      ],
    );
  }

  Widget _buildRow(String label, String? value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label),
        Text(value ?? '???')
      ],
    );
  }
}

extension ToPercentExtension on double? {
  String get _toPercent => this == null
      ? '???'
      : '${(this! * 100).round()}%';
}
