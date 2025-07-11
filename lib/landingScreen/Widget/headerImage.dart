import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:host_visitor_connect/common/res/paths.dart';
import 'package:host_visitor_connect/common/res/styles.dart';
import 'package:host_visitor_connect/common/utils/utils.dart';

class HeaderImage extends StatelessWidget {
  final String? imageLeft;
  final String? imageRight;
  const HeaderImage({super.key, this.imageLeft, this.imageRight});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: appSize(context: context, unit: 10) / 20),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Image.asset(
                imageLeft ?? "$images_path/goaPolice.png",
                height: sizeHeight(context) / 9,
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Image.asset(
                imageRight ?? "$images_path/onboarding_logo.png",
                height: sizeHeight(context) / 6.8,
              ),
            ),
          )
        ],
      ),
    );
  }
}
