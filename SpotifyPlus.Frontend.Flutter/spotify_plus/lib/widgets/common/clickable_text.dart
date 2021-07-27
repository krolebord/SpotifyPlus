import 'package:flutter/material.dart';

class ClickableText extends StatefulWidget {
  final String text;
  final void Function() onTap;
  final TextStyle? style;
  final TextStyle? hoverStyle;

  const ClickableText({
    required this.text,
    required this.onTap,
    this.style,
    TextStyle? hoverStyle,
    Key? key
  }) :
    hoverStyle = hoverStyle ?? style,
    super(key: key);

  @override
  _ClickableTextState createState() => _ClickableTextState();
}

class _ClickableTextState extends State<ClickableText> {
  bool hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: MaterialStateMouseCursor.clickable,
      onEnter: (_) => setState(() => hovered = true),
      onExit: (_) => setState(() => hovered = false),
      child: GestureDetector(
        child: Text(
          widget.text,
          style: hovered ? widget.hoverStyle : widget.style,
          overflow: TextOverflow.ellipsis,
        ),
        onTap: widget.onTap,
      ),
    );
  }
}
