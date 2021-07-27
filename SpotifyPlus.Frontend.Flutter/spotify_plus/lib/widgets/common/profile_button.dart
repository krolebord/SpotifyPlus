import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:spotify_plus/services/auth/auth_service.dart';

class ProfileButton extends StatelessWidget {
  final AuthService _authService = GetIt.instance.get<AuthService>();

  ProfileButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      child: const Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 10
        ),
        child:Center(child: Text("Menu")),
      ),
      itemBuilder: (context) => [
        PopupMenuItem(
          onTap: _authService.signOut,
          child: const Text('Log out')
        )
      ]
    );
  }
}
