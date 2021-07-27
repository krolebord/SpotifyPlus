import 'package:flutter/material.dart';
import 'package:spotify_plus/mixins/rebuild_children_mixin.dart';
import 'package:spotify_plus/widgets/common/safe_future_builder.dart';

class SpotifyWidget<TData> extends StatefulWidget {
  final Future<TData> Function() futureBuilder;
  final Widget Function(BuildContext context, TData data) builder;
  final Widget label;
  final double? width;
  final double? height;

  const SpotifyWidget({
    required this.futureBuilder,
    required this.builder,
    required this.label,
    this.width,
    this.height,
    Key? key
  }) : super(key: key);

  @override
  State<SpotifyWidget> createState() => _PlayerWidgetState<TData>();
}

class _PlayerWidgetState<TData> extends State<SpotifyWidget<TData>> with RebuildChildrenMixin {
  @override
  Widget build(BuildContext context) {
    final playerContent = SafeFutureBuilder<TData>(
      key: shouldRebuildKey,
      futureBuilder: widget.futureBuilder,
      dataBuilder: widget.builder,
      loadingBuilder: _buildLoading,
      errorBuilder: _buildError,
    );

    final refreshButton = IconButton(
      padding: EdgeInsets.zero,
      iconSize: 18,
      constraints: const BoxConstraints(maxWidth: 24, maxHeight: 24),
      splashRadius: 16,
      tooltip: 'Refresh',
      onPressed: rebuildChildren,
      icon: const Icon(Icons.refresh),
    );

    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  widget.label,
                  refreshButton
                ],
              ),
            ),
            Expanded(
              child: playerContent
            )
          ],
        )
      ),
    );
  }

  Widget _buildLoading(BuildContext context) {
    return const Center(
        child: CircularProgressIndicator()
    );
  }

  Widget _buildError(BuildContext context, Object error) {
    return const Center(
      child: Text("Couldn't load data")
    );
  }
}
