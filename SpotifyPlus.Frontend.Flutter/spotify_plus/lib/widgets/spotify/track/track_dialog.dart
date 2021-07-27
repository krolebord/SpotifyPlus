import 'dart:math';
import 'package:flutter/material.dart';
import 'package:spotify/spotify.dart';
import 'package:spotify_plus/extensions/size_extension.dart';
import 'package:spotify_plus/widgets/spotify/track/track_detailed_widget.dart';

class TrackDialog extends StatelessWidget {
  final Track track;

  const TrackDialog({
    required this.track,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: 400, maxWidth: max(0.5.w, 400),
          minHeight: 100, maxHeight: max(0.8.h, 200)
        ),
        child: TrackDetailedWidget(track: track)
      ),
    );
  }

  static Future<void> show(BuildContext context, Track track) {
    return showDialog(
      context: context,
      builder: (context) => TrackDialog(track: track)
    );
  }
}
