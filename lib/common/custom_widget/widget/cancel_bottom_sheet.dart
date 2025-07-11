import 'package:flutter/material.dart';
import 'package:host_visitor_connect/common/custom_widget/dots_progress_button.dart';
import 'package:host_visitor_connect/common/res/styles.dart';

class CancelBottomSheet extends StatelessWidget {
  const CancelBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.only(
                left: 20.0,
                right: 20,
                top: appSize(context: context, unit: 10) / 20,
                bottom: appSize(context: context, unit: 10) / 8),
            child: DotsProgressButton(
              text: "Cancel",
              isRectangularBorder: true,
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ));
  }
}