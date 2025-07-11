import 'package:flutter/material.dart';
import 'package:host_visitor_connect/common/res/colors.dart';
import 'package:host_visitor_connect/common/res/styles.dart';

class FilterHeader extends StatelessWidget {
  final String? title;
  final void Function()? onTap;
  const FilterHeader({super.key, this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title ?? '',
          style: AppStyle.headlineSmall(context)
              .copyWith(fontWeight: FontWeight.w600),
        ),
        const Spacer(),
        GestureDetector(
          onTap: onTap ?? () => Navigator.pop(context),
          child: const CircleAvatar(
            radius: 15,
            backgroundColor: buttonColor,
            child: Center(
              child: Icon(
                size: 25,
                Icons.clear_rounded,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
