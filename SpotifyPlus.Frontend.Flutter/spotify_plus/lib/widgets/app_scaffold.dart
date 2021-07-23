import 'package:flutter/material.dart';
import 'package:spotify_plus/spotify_plus_app.dart';

class AppScaffold extends StatelessWidget {
  final Widget body;

  const AppScaffold({required this.body, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(SpotifyPlusApp.appTitle)),
      body: body,
    );
  }
}
