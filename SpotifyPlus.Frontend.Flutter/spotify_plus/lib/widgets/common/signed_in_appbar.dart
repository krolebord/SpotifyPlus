import 'package:flutter/material.dart';
import 'package:spotify_plus/widgets/common/profile_button.dart';
import '../../spotify_plus_app.dart';

class SignedInAppbar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;

  const SignedInAppbar({Key? key}) :
    preferredSize = const Size.fromHeight(kToolbarHeight),
    super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(SpotifyPlusApp.appTitle),
      actions: [
        ProfileButton()
      ],
    );
  }
}
