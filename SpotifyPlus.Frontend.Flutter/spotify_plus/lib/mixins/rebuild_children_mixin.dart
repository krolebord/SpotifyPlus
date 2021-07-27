import 'package:flutter/material.dart';

mixin RebuildChildrenMixin<TWidget extends StatefulWidget> on State<TWidget> {
  late bool _rebuildFlag = false;

  Key get shouldRebuildKey => ValueKey<bool>(_rebuildFlag);

  @override
  void initState() {
    super.initState();
    _rebuildFlag = false;
  }

  void rebuildChildren() {
    setState(() {
      _rebuildFlag = !_rebuildFlag;
    });
  }
}