import 'package:flutter/material.dart';
import 'package:host_visitor_connect/common/res/styles.dart';

class NavigationItem extends StatelessWidget {
  final String iconPath;
  final String title;
  final double? width;
  final double? height;
  final Color? color;
  final TextStyle? titleStyle; // Added for customizable title style

  final Function() onTap;

  const NavigationItem({
    Key? key,
    required this.iconPath,
    required this.title,
    required this.onTap,
    this.width,
    this.height,
    this.color,
    this.titleStyle, // Added for customizable title style
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ConstrainedBox(
        constraints: const BoxConstraints(),
        child: Image.asset(
          iconPath,
          width: width,
          height: height,
          color: color,
        ),
      ),
      title: Text(
        title,
        style:
            titleStyle ?? // Use custom style if provided, otherwise use default style
                AppStyle.titleLarge(context).copyWith(
                    fontSize: appSize(context: context, unit: 10) / 15,
                    color: Colors.white,
                    fontWeight: FontWeight.w400),
      ),
      onTap: onTap,
    );
  }
}
