import 'package:flutter/material.dart';
import 'package:host_visitor_connect/common/res/paths.dart';

class FooterImage extends StatelessWidget {
  final String? image;
  const FooterImage({super.key, this.image});

  @override
  Widget build(BuildContext context) {
    return Image.asset(image ?? "$images_path/goaElectronic.png");
  }
}
