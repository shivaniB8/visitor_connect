import 'package:flutter/material.dart';
import 'package:host_visitor_connect/common/custom_widget/button.dart';
import 'package:host_visitor_connect/common/custom_widget/pulse_dots_progress/pulse_dots_progress.dart';
import 'package:host_visitor_connect/common/res/colors.dart';
import 'package:host_visitor_connect/common/res/styles.dart';

/// Button which shows dots progress as well as text without changing button width
class DotsProgressButton extends StatelessWidget {
  final String? text;
  final Color? textColor;
  final Widget? child;
  final bool isProgress;
  final Function()? onPressed;
  final bool isRectangularBorder;
  final Color? buttonBackgroundColor;
  final Color? textBackgroundColor;
  final bool disableButton;
  final TextStyle? style;
  final EdgeInsets? padding;
  final bool? expanded;
  final double? btnHeight;
  final double? btnWidth;

  const DotsProgressButton({
    Key? key,
    this.text,
    this.child,
    this.padding,
    this.expanded,
    this.isProgress = false,
    this.onPressed,
    this.isRectangularBorder = false,
    this.buttonBackgroundColor = primary_color,
    this.textBackgroundColor = Colors.white,
    this.disableButton = false,
    this.style,
    this.textColor,
    this.btnHeight,
    this.btnWidth,
  })  : assert(
          text != null || child != null,
          'text and child both cannot be null',
        ),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    // Wraps both text as well as progress indicator on same button so that
    // same width is maintained for both child
    return Button(
      btnWidth: btnWidth,
      btnHeight: btnHeight,
      isRectangularBorder: isRectangularBorder,
      backgroundColor: disableButton ? Colors.grey : buttonBackgroundColor,
      // Button should be enabled for progress indicator that's why empty function is passed
      onPressed: isProgress
          ? () {}
          : disableButton
              ? () {}
              : onPressed,
      padding: padding,
      expanded: expanded,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Visibility(
            visible: !isProgress,
            maintainSize: true,
            maintainAnimation: true,
            maintainState: true,
            child: child ??
                Text(
                  text ?? '',
                  style: style ??
                      AppStyle.buttonStyle(context).copyWith(color: textColor),
                ),
          ),
          // In case if button text width is less than pulse dots progress width,
          // maintain min button size of 70 i.e. width of dots progress
          // so that while showing progress, button width will not expand
          !isProgress ? const SizedBox(width: 70) : const PulseDotsProgress(),
        ],
      ),
    );
  }
}
