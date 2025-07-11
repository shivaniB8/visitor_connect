import 'package:flutter/material.dart';
import 'package:host_visitor_connect/common/res/styles.dart';

class DashboardTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String iconPath;
  const DashboardTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.iconPath,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
      ),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        shadowColor: Colors.grey.shade200,
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ShaderMask(
                shaderCallback: (Rect bunds) {
                  return const LinearGradient(
                    colors: [
                      Colors.deepPurpleAccent,
                      Colors.pinkAccent,
                    ],
                    stops: [
                      0.2,
                      1,
                    ],
                  ).createShader(bunds);
                },
                blendMode: BlendMode.srcATop,
                child: Image.asset(
                  iconPath,
                  height: 50,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: text_style_title11.copyWith(color: Colors.black),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      subtitle,
                      style: text_style_para2,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
