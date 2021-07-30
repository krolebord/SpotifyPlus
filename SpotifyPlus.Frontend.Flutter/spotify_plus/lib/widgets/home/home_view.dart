import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_plus/cubit/auth/auth_cubit.dart';
import 'package:spotify_plus/widgets/common/signed_in_appbar.dart';
import 'package:spotify_plus/widgets/spotify/display/currently_playing_display.dart';
import 'package:spotify_plus/widgets/spotify/display/recommendations_display.dart';
import 'package:spotify_plus/widgets/spotify/display/top_tracks_display.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SignedInAppbar(),
      body: BlocBuilder<AuthCubit, AuthState>(
        key: const ValueKey(33),
        buildWhen: (previous, current) => current is AuthSignedIn,
        builder: _buildBody,
      )
    );
  }

  Widget _buildBody(BuildContext context, AuthState state) {
    return Center(
      child: Wrap(
        children: const [
          TopTracksDisplay(),
          RecommendationsDisplay(),
          CurrentlyPlayingDisplay(),
        ],
      ),
    );
  }
}
