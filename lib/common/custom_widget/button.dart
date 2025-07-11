import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:host_visitor_connect/common/constant/globalVariable.dart';
import 'package:host_visitor_connect/common/res/colors.dart';
import 'package:host_visitor_connect/common/res/styles.dart';

enum ButtonType { solid, stroked }

class Button extends StatelessWidget {
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
  final TextStyle? style;

  /// Spacing between leading icon and text
  final double? leadingIconSpace;

  /// Spacing between trailing icon and text
  final double? trailingIconSpace;

  final bool isRectangularBorder;
  final double? btnHeight;
  final double? btnWidth;
  final bool? expanded;

  const Button({
    Key? key,
    this.text,
    this.child,
    this.expanded,
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
    this.btnHeight,
    this.style,
    this.btnWidth,
  })  : assert(
          text != null || child != null,
          'text and child both cannot be null',
        ),
        super(key: key);

  Widget _getButtonByType(context) {
    switch (buttonType) {
      case ButtonType.solid:
        return _getSolidButton(context);
      case ButtonType.stroked:
        return _getStrokedButton(context);
      default:
        return _getSolidButton(context);
    }
  }

  Widget _getStrokedButton(context) {
    return SizedBox(
      height: btnHeight,
      width: btnWidth,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: borderColor ?? gray_color,
          backgroundColor: backgroundColor,
          shape: _getButtonBorder(),
          side: BorderSide(
            width: 2,
            color: borderColor ?? gray_color,
          ),
          padding: padding,
        ),
        child: _getChild(context),
      ),
    );
  }

  Widget _getSolidButton(context) {
    return SizedBox(
      height: btnHeight,
      width: btnWidth,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith(
            (states) {
              if (states.contains(MaterialState.disabled)) {
                return disabled_color;
              }
              return backgroundColor ?? primary_color;
            },
          ),
          shape: MaterialStateProperty.all(
            _getButtonBorder(),
          ),
          foregroundColor: MaterialStateProperty.all(_getTextColor()),
          padding: MaterialStateProperty.all(padding),
        ),
        child: _getChild(context),
      ),
    );
  }

  Widget _getChild(context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        leading ?? const SizedBox.shrink(),
        if (leading != null)
          SizedBox(
            width: leadingIconSpace ?? 8,
          ),
        expanded == true
            ? Expanded(
                child: child ??
                    Text(
                      text ?? '',
                      style: style ??
                          TextStyle(
                            fontFamily: GlobalVariable.fontFamily,
                            fontSize: appSize(context: context, unit: 10) / 12,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
              )
            : child ??
                Text(
                  text ?? '',
                  style: style ??
                      TextStyle(
                        fontFamily: GlobalVariable.fontFamily,
                        fontSize: appSize(context: context, unit: 10) / 12,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
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
        ? RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0))
        : const StadiumBorder();
  }

  @override
  Widget build(BuildContext context) {
    return _getButtonByType(context);
  }
}
