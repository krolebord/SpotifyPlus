import 'package:flutter/material.dart';

class MoreButton extends StatelessWidget {
  final List<PopupMenuItem> actions;

  const MoreButton({
    required this.actions,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 28,
      height: 28,
      child: PopupMenuButton(
        tooltip: "Actions",
        padding: EdgeInsets.zero,
        icon: const Icon(Icons.more_vert),
        enableFeedback: false,
        itemBuilder: (context) => actions,
      ),
    );
  }
}
