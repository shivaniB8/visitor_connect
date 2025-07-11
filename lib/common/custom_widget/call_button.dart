import 'package:flutter/material.dart';
import 'package:host_visitor_connect/common/res/colors.dart';
import 'package:host_visitor_connect/common/res/styles.dart';

enum ButtonType { solid, stroked }

class CallButton extends StatelessWidget {
  final String? text;
  final Widget? child;
  final Function()? onPressed;
  final ButtonType? buttonType;
  final Color? textColor;
  final Widget? leading;
  final Widget? trailing;
  final Color? backgroundColor;
  final EdgeInsets? padding;
  final Color? borderColor;

  /// Spacing between leading icon and text
  final double? leadingIconSpace;

  /// Spacing between trailing icon and text
  final double? trailingIconSpace;

  final bool isRectangularBorder;

  const CallButton({
    Key? key,
    this.text,
    this.child,
    this.onPressed,
    this.buttonType,
    this.textColor,
    this.leading,
    this.trailing,
    this.backgroundColor,
    this.padding,
    this.leadingIconSpace,
    this.trailingIconSpace,
    this.borderColor,
    this.isRectangularBorder = false,
  })  : assert(
          text != null || child != null,
          'text and child both cannot be null',
        ),
        super(key: key);

  Widget _getButtonByType() {
    switch (buttonType) {
      case ButtonType.solid:
        return _getSolidButton();
      case ButtonType.stroked:
        return _getStrokedButton();
      default:
        return _getSolidButton();
    }
  }

  Widget _getStrokedButton() {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: borderColor ?? gray_color,
        backgroundColor: backgroundColor,
        shape: _getButtonBorder(),
        side: BorderSide(
          width: 1,
          color: borderColor ?? gray_color,
        ),
        padding: padding,
      ),
      child: _getChild(),
    );
  }

  Widget _getSolidButton() {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith(
          (states) {
            if (states.contains(MaterialState.disabled)) {
              return disabled_color;
            }
            return backgroundColor ?? buttonColor;
          },
        ),
        shape: MaterialStateProperty.all(
          _getButtonBorder(),
        ),
        foregroundColor: MaterialStateProperty.all(_getTextColor()),
        padding: MaterialStateProperty.all(padding),
      ),
      child: _getChild(),
    );
  }

  Widget _getChild() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        leading ?? const SizedBox.shrink(),
        if (leading != null)
          SizedBox(
            width: leadingIconSpace ?? 8,
          ),
        child ??
            Text(
              text ?? '',
              style: text_style_title11.copyWith(color: Colors.white),
            ),
        if (trailing != null)
          SizedBox(
            width: trailingIconSpace ?? 8,
          ),
        trailing ?? const SizedBox.shrink(),
      ],
    );
  }

  Color _getTextColor() {
    return textColor ?? _getTextColorByButtonType();
  }

  Color _getTextColorByButtonType() {
    if (buttonType == ButtonType.stroked) {
      return gray_color;
    }
    return Colors.white;
  }

  OutlinedBorder _getButtonBorder() {
    return isRectangularBorder
        ? RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))
        : const StadiumBorder();
  }

  @override
  Widget build(BuildContext context) {
    return _getButtonByType();
  }
}
