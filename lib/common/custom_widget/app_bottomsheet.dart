import 'package:flutter/material.dart';
import 'package:host_visitor_connect/common/res/styles.dart';


class AppBottomSheet {
  static void showAppSnackBar({
    required BuildContext context,
    required String text,
    Color textColor = Colors.white,
    Color snackBarBGColor = Colors.black,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          text,
          style: AppStyle.bodyMedium(context).copyWith(color: textColor),
        ),
        backgroundColor: snackBarBGColor,
      ),
    );
  }
}
