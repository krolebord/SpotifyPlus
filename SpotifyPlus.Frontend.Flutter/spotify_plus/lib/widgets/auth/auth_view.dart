import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_plus/cubit/auth/auth_cubit.dart';
import 'package:spotify_plus/widgets/app_scaffold.dart';

class AuthView extends StatelessWidget {
  const AuthView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: _listenAuth,
        builder: _buildAuth,
      ),
    );
  }

  void _listenAuth(BuildContext context, AuthState state) {
    if(state is AuthError) {
      ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Couldn't authenticate")));
    }
  }

  Widget _buildAuth(BuildContext context, AuthState state) {
    if(state is AuthSignedOut) {
      return Center(
        child: ElevatedButton(
          onPressed: () => context.read<AuthCubit>().signInWithSpotify(),
          child: const Text('Sign in with spotify')
        ),
      );
    }

    return const Center(child: CircularProgressIndicator());
  }
}
