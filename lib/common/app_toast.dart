import 'package:flutter/material.dart';
import 'package:host_visitor_connect/common/res/colors.dart';
import 'package:host_visitor_connect/common/res/styles.dart';

enum ToastStatus {
  invalid,
  neutral,
  valid,
}

class AppToast extends StatelessWidget {
  final String toastMessage;
  final Function? onDismiss;
  final ToastStatus? status;

  const AppToast({
    Key? key,
    required this.toastMessage,
    this.onDismiss,
    this.status = ToastStatus.neutral,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final toastConfig = _getToastConfig();

    return Container(
      padding: const EdgeInsets.only(left: 16),

      //..
      decoration: BoxDecoration(
        color: toastConfig.bgColor,
        borderRadius: BorderRadius.circular(8),

        //border
        border: Border.all(
          color: toastConfig.strokeColor,
          width: 2,
        ),

        //shadow
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: toastConfig.bgColor.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),

      //icon, message & action button
      child: Row(
        children: [
          // // Toast icon
          Icon(
            toastConfig.iconPath,
            color: toastConfig.strokeColor,
          ),

          // Toast message
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                toastMessage,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: text_style_title1.copyWith(
                    fontSize: 12, color: Colors.black),
              ),
            ),
          ),

          IconButton(
            onPressed: () {
              onDismiss?.call();
            },
            icon: const Icon(
              Icons.close,
              size: 14,
            ),
          ),
        ],
      ),
    );
  }

  ToastConfig _getToastConfig() {
    switch (status) {
      case ToastStatus.valid:
        return ToastConfig(
          iconPath: Icons.check_outlined,
          bgColor: toast_valid_bg_color,
          strokeColor: toast_valid_stroke_color,
        );

      case ToastStatus.invalid:
        return ToastConfig(
          iconPath: Icons.clear_outlined,
          bgColor: toast_invalid_bg_color,
          strokeColor: toast_invalid_stroke_color,
        );

      case ToastStatus.neutral:
      default:
        return ToastConfig(
          iconPath: Icons.help_outline,
          bgColor: toast_neutral_bg_color,
          strokeColor: toast_neutral_stroke_color,
        );
    }
  }
}

class ToastConfig {
  final IconData iconPath;
  final Color bgColor;
  final Color strokeColor;

  ToastConfig({
    required this.iconPath,
    required this.bgColor,
    required this.strokeColor,
  });
}
