import 'package:flutter/material.dart';
import 'package:host_visitor_connect/common/custom_widget/loading.dart';
import 'package:host_visitor_connect/common/res/colors.dart';
import 'package:host_visitor_connect/common/res/styles.dart';
import 'package:host_visitor_connect/common/utils/utils.dart';

class WaitingDialog {
  static showloading(BuildContext context, String? text) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return PopScope(
          canPop: false,
          child: AlertDialog(
            insetPadding:
                EdgeInsets.symmetric(horizontal: sizeHeight(context) / 30),
            contentPadding: const EdgeInsets.all(10),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8))),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const LoadingWidget(),
                SizedBox(
                  height: sizeHeight(context) / 50,
                ),
                Text(
                  text ?? "Please Wait...",
                  style: AppStyle.bodyLarge(context).copyWith(
                      color: visitorNameColor, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
