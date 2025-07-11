import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:host_visitor_connect/common/res/paths.dart';
import 'package:host_visitor_connect/common/res/styles.dart';

class BlankSlate extends StatelessWidget {
  final String title;

  const BlankSlate({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            SvgPicture.asset(
              '$images_path/no_data.svg',
            ),
            Positioned(
              top: 350,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(40.0),
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: text_style_title2.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
