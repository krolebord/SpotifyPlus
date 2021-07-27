import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:spotify/spotify.dart' hide Image;
import 'package:spotify_plus/services/api_service/api_service.dart';
import 'package:spotify_plus/widgets/common/clickable_text.dart';
import 'package:spotify_plus/widgets/common/more_button.dart';
import 'package:spotify_plus/widgets/spotify/track/track_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

class TrackWidget extends StatelessWidget {
  final Track track;
  final bool? dense;

  static const double _openInSpotifyIconSize = 12;

  const TrackWidget({
    required this.track,
    this.dense,
    Key? key
  }) : super(key: key);

  String? get _trackUri => track.uri;

  @override
  Widget build(BuildContext context) {
    Widget? leading = track.album?.images?.last.url?.isNotEmpty != true
      ? null
      : MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: _tryPlay,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Image.network(track.album!.images!.last.url!)
          ),
        ),
      );

    Widget title = RichText(
      maxLines: 1,
      text: TextSpan(
        children: [
          WidgetSpan(
            child: ClickableText(
              text: track.name ?? "Unknown track",
              onTap: () => _showDetails(context),
              hoverStyle: const TextStyle(decoration: TextDecoration.underline),
            )
          ),
          WidgetSpan(
            child: Padding(
              padding: const EdgeInsets.only(left: 4, bottom: 3),
              child: IconButton(
                onPressed: () => _tryOpen(_trackUri),
                tooltip: "Open in spotify",
                constraints: const BoxConstraints.tightFor(width: _openInSpotifyIconSize, height: _openInSpotifyIconSize),
                padding: EdgeInsets.zero,
                iconSize: _openInSpotifyIconSize,
                splashRadius: 18,
                icon: const Icon(Icons.open_in_new),
              ),
            )
          )
        ]
      ),
    );

    late Widget subtitle;

    if(track.artists == null || track.artists!.length <= 1) {
      subtitle = _buildArtistLabel(track.artists?.first ?? Artist());
    }
    else {
      const comma = WidgetSpan(child: Text(', '));

      final List<InlineSpan> artistLabels = track.artists!
          .map((artist) => WidgetSpan(child: _buildArtistLabel(artist)))
          .expand((element) => [element, comma])
          .toList()..removeLast();

      subtitle = RichText(
        maxLines: 1,
        text: TextSpan(
            children: artistLabels
        ),
      );
    }

    return ListTile(
      leading: leading,
      title: title,
      subtitle: subtitle,
      trailing: _buildMoreButton(),
      dense: dense
    );
  }

  Widget _buildMoreButton() {
    return MoreButton(
      actions: [
        PopupMenuItem(
          onTap: () => _tryOpen(_trackUri),
          child: const Text('Open in spotify')
        ),
        PopupMenuItem(
          onTap: () => _tryPlay(),
          child: const Text('Play in spotify'),
        )
      ],
    );
  }

  Widget _buildArtistLabel(Artist artist) {
    return ClickableText(
      text: artist.name ?? "Unknown artist",
      onTap: () => _tryOpen(artist.uri),
      hoverStyle: const TextStyle(decoration: TextDecoration.underline),
    );
  }

  Future<bool> _canOpen(String? uri) async {
    return uri?.isNotEmpty == true && await canLaunch(uri!);
  }

  Future<bool> _tryOpen(String? uri) async {
    if(!await _canOpen(uri)) {
      return false;
    }
    return launch(uri!);
  }

  Future<void> _tryPlay() {
    return GetIt.instance.get<ApiService>().playTrack(track);
  }

  void _showDetails(BuildContext context) {
    TrackDialog.show(context, track);
  }
}
