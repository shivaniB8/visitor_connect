import 'package:flutter/material.dart';
import 'package:host_visitor_connect/common/res/colors.dart';

class IconsButtonApp extends StatelessWidget {
  final void Function()? onPressed;
  final Widget icon;
  const IconsButtonApp(
      {super.key, required this.onPressed, required this.icon});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      focusColor: primary_text_color.withOpacity(0.4),
      splashColor: primary_text_color.withOpacity(0.4),
      highlightColor: primary_text_color.withOpacity(0.4),
      onPressed: onPressed,
      icon: icon,
    );
  }
}
