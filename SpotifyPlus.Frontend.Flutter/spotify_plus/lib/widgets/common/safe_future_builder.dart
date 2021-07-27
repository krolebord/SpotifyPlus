import 'package:flutter/material.dart';

class SafeFutureBuilder<TData> extends StatefulWidget {
  final Future<TData> Function() futureBuilder;

  final Widget Function(BuildContext context)? loadingBuilder;
  final Widget Function(BuildContext context, TData data) dataBuilder;
  final Widget Function(BuildContext context, Object error)? errorBuilder;

  final String Function(Object error)? defaultErrorMessageBuilder;

  const SafeFutureBuilder({
    required this.futureBuilder,
    required this.dataBuilder,
    this.loadingBuilder,
    this.errorBuilder,
    this.defaultErrorMessageBuilder,
    Key? key
  }) : super(key: key);

  @override
  State<SafeFutureBuilder> createState() => _SafeFutureBuilderState<TData>();
}

class _SafeFutureBuilderState<TData> extends State<SafeFutureBuilder<TData>> {
  late bool _disposed;

  Object? _error;
  TData? _data;

  @override
  void initState() {
    super.initState();

    _disposed = false;
    _startFuture();
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  void _clear() {
    _error = null;
    _data = null;
  }

  void _startFuture() async {
    _clear();

    var future = widget.futureBuilder();

    try {
      var data = await future;

      if(!_disposed) {
        setState(() => _data = data);
      }
    }
    catch(error) {
      if(!_disposed) {
        setState(() => _error = error);
      }
    }
  }

  void _retry() {
    setState(_clear);
    _startFuture();
  }

  @override
  Widget build(BuildContext context) {
    if(_data != null) {
      return widget.dataBuilder(context, _data!);
    }

    if(_error != null) {
      return (widget.errorBuilder ?? _defaultErrorBuilder).call(context, _error!);
    }

    return (widget.loadingBuilder ?? _defaultLoadingBuilder).call(context);
  }

  Widget _defaultLoadingBuilder(BuildContext context) {
    return const Center(child: Padding(
      padding: EdgeInsets.all(8.0),
      child: CircularProgressIndicator(),
    ));
  }

  Widget _defaultErrorBuilder(BuildContext context, Object error) {
    final errorText = Text(widget.defaultErrorMessageBuilder?.call(error) ?? "Couldn't load data");

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        errorText,
        IconButton(
          icon: const Icon(Icons.refresh),
          tooltip: "Retry",
          onPressed: _retry,
        )
      ],
    );
  }
}
