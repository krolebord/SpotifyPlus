import 'package:flutter/material.dart';
import 'package:spotify/spotify.dart';
import 'package:spotify_plus/extensions/iterable_extensions.dart';

class TrackFeaturesWidget extends StatelessWidget {
  final AudioFeature features;

  const TrackFeaturesWidget({
    required this.features,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final rows = <Widget>[
          _buildRow('Acousticness:', features.acousticness._toPercent),
          _buildRow('Instrumentalness:', features.instrumentalness._toPercent),
          _buildRow('Liveness:', features.liveness._toPercent),
          _buildRow('Valence:', features.valence._toPercent),
          _buildRow('Danceability:', features.danceability._toPercent),
          _buildRow('Energy:', features.energy._toPercent),
          _buildRow('Speechiness:', features.speechiness._toPercent),
          _buildRow('Key:', features.key.toString()),
          _buildRow('Average loudness:', features.loudness != null ? '${features.loudness} db' : null),
          _buildRow('Average tempo:', features.tempo != null ? '${features.tempo!.round()} bpm' : null),
        ];

        if(constraints.maxWidth > 500) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: rows
                      .whereWithIndex((index, item) => index % 2 != 0)
                      .toList(),
                ),
              ),
              const SizedBox(width: 18),
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: rows
                    .whereWithIndex((index, item) => index % 2 != 1)
                    .toList()
                ),
              )
            ],
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: rows,
        );
      }
    );
  }

  Widget _buildRow(String label, String? value) {
    return Row(
      mainAxisSize: MainAxisSize.max,
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
