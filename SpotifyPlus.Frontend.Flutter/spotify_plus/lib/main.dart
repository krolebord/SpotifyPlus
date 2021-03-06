import 'package:flutter/material.dart';
import 'package:spotify_plus/configure_services.dart';
import 'package:spotify_plus/spotify_plus_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  configureServices();

  runApp(const SpotifyPlusApp());
}
