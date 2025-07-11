import 'package:flutter/material.dart';
import 'package:host_visitor_connect/common/res/colors.dart';
import 'package:host_visitor_connect/common/res/paths.dart';

class BackGroundWidget extends StatelessWidget {
  final String? image;
  final Color? backgroundColor;
  const BackGroundWidget({super.key, this.image, this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          image ?? "$images_path/splash1.jpeg",
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
        Container(
          color: backgroundColor ?? text_color.withOpacity(0.9),
          width: double.infinity,
          height: double.infinity,
        )
      ],
    );
  }
}
