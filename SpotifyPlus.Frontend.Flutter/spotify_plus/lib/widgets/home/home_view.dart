import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/spotify.dart';
import 'package:spotify_plus/cubit/auth/auth_cubit.dart';
import 'package:spotify_plus/models/auth/auth_data.dart';
import 'package:spotify_plus/spotify_plus_app.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(SpotifyPlusApp.appTitle),
        actions: [
          IconButton(
            onPressed: () => setState(() {}),
            icon: const Icon(Icons.refresh)
          )
        ],
      ),
      body: BlocBuilder<AuthCubit, AuthState>(
        builder: _buildBody,
      )
    );
  }

  Widget _buildBody(BuildContext context, AuthState state) {
    if(state is! AuthSignedIn) {
      throw Exception("Auth state is not AuthSignedIn");
    }

    return Center(
      child: FutureBuilder<Player>(
        future: _test(state.authData),
        builder: (context, snapshot) {
          if(snapshot.hasError) {
            return Text(snapshot.error.toString());
          }

          if(!snapshot.hasData) {
            return const Text('Loading...');
          }

          var player = snapshot.data!;

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Is playing: ${player.is_playing}'),
              Text('Song: ${player.item?.name}'),
              Text('By: ${player.item?.artists?.first.name}'),
              Text('With popularity: ${player.item?.popularity}'),
              if(player.item != null && player.item!.uri != null)
                ElevatedButton(
                  onPressed: () => launch(player.item!.uri!),
                  child: const Text('Open in spotify'),
                )
            ]
          );
        },
      ),
    );
  }

  Future<Player> _test(AuthData authData) async {
    var credentials = SpotifyApiCredentials(
        "", "",
        accessToken: authData.accessToken,
        refreshToken: authData.refreshToken,
        scopes: authData.scope.split(' '),
        expiration: DateTime.now().add(Duration(seconds: authData.expiresIn))
    );

    var spotify = SpotifyApi(credentials);

    // var t = await spotify.recommendations.

    var track = await spotify.me.currentlyPlaying();

    return track;
  }
}
