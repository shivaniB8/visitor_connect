// ignore_for_file: constant_identifier_names
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:host_visitor_connect/common/constant/globalVariable.dart';
import 'package:host_visitor_connect/common/res/colors.dart';
import 'package:host_visitor_connect/common/utils/utils.dart';

const text_style_title1 = TextStyle(
  fontSize: 26,
  fontWeight: FontWeight.w600,
  color: primary_text_color,
  fontFamily: GlobalVariable.fontFamily,
);

const text_style_title2 = TextStyle(
  fontSize: 24,
  fontWeight: FontWeight.w600,
  color: primary_text_color,
  fontFamily: GlobalVariable.fontFamily,
);

const text_style_title3 = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.w400,
  color: primary_text_color,
  fontFamily: GlobalVariable.fontFamily,
);

const text_style_title4 = TextStyle(
  fontSize: 17,
  fontWeight: FontWeight.w500,
  color: primary_text_color,
  fontFamily: GlobalVariable.fontFamily,
);

const text_style_title5 = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.w600,
  color: primary_color,
  fontFamily: GlobalVariable.fontFamily,
);

const text_style_basic = TextStyle(
  fontSize: 14,
  color: primary_color,
  fontFamily: GlobalVariable.fontFamily,
);

const text_style_title6 = TextStyle(
  fontSize: 24,
  fontWeight: FontWeight.w500,
  color: text_color,
  fontFamily: GlobalVariable.fontFamily,
);

const text_style_title7 = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.w500,
  color: text_color,
  fontFamily: GlobalVariable.fontFamily,
);

const text_style_title8 = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w500,
  color: text_color,
  fontFamily: GlobalVariable.fontFamily,
);

const text_style_title11 = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.w500,
  color: text_color,
  fontFamily: GlobalVariable.fontFamily,
);

const text_style_title12 = TextStyle(
  fontSize: 12,
  fontWeight: FontWeight.w500,
  fontFamily: GlobalVariable.fontFamily,
  color: text_color,
);

const text_style_title13 = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.w500,
  color: text_color,
  fontFamily: GlobalVariable.fontFamily,
);

const text_style_title15 = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.w500,
  color: text_color,
  fontFamily: GlobalVariable.fontFamily,
);

const text_style_para1 = TextStyle(
  fontSize: 14,
  color: text_color,
  fontFamily: GlobalVariable.fontFamily,
);

const text_style_para2 = TextStyle(
  fontSize: 12,
  fontFamily: GlobalVariable.fontFamily,
  color: text_color,
);

const text_style_para3 = TextStyle(
  fontSize: 10,
  color: text_color,
  fontFamily: GlobalVariable.fontFamily,
);
const form_field_input_decoration = InputDecoration(
  border: InputBorder.none,
  hintStyle: text_style_title4,
  fillColor: textFeildFillColor,

  /// to hide default error showing at the bottom of field
  errorStyle: TextStyle(
    height: 0,
    color: Colors.transparent,
    fontFamily: GlobalVariable.fontFamily,
  ),
);

double appSize({required BuildContext context, required double unit}) {
  double baseUnit = 100;
  double s =
      MediaQuery.of(context).size.height + MediaQuery.of(context).size.width;
  double value = s / 100 * unit + baseUnit;
  return value;
}

class AppStyle {
// Headline
  static TextStyle headlineLarge(BuildContext context) => TextStyle(
        fontFamily: GlobalVariable.fontFamily,
        fontSize: 24.sp, // Adjust as necessary
        color: text_color,
        fontWeight: FontWeight.w500,
      );

  static TextStyle headlineMedium(BuildContext context) => TextStyle(
        fontFamily: GlobalVariable.fontFamily,
        fontSize: 20.sp, // Adjust as necessary
        color: text_color,
        fontWeight: FontWeight.w500,
      );

  static TextStyle headlineSmall(BuildContext context) => TextStyle(
        fontFamily: GlobalVariable.fontFamily,
        fontSize: 18.sp, // Adjust as necessary
        color: text_color,
        fontWeight: FontWeight.w500,
      );

  // titles
  static TextStyle titleLarge(BuildContext context) => TextStyle(
        fontFamily: GlobalVariable.fontFamily,
        fontSize: 16.sp, // Adjust as necessary
        fontWeight: FontWeight.w500,
        color: text_color,
      );

  static TextStyle titleMedium(BuildContext context) => TextStyle(
        fontFamily: GlobalVariable.fontFamily,
        fontSize: 15.sp, // Adjust as necessary
        color: text_color,
      );

  static TextStyle titleSmall(BuildContext context) => TextStyle(
        fontFamily: GlobalVariable.fontFamily,
        fontSize: 14.sp, // Adjust as necessary
        color: text_color,
      );

  // body
  static TextStyle bodyLarge(BuildContext context) => TextStyle(
        fontFamily: GlobalVariable.fontFamily,
        fontSize: 13.sp, // Adjust as necessary
        color: text_color,
      );
  static TextStyle bodyMedium(BuildContext context) => TextStyle(
        fontFamily: GlobalVariable.fontFamily,
        fontSize: 12.sp, // Adjust as necessary
        color: text_color,
      );
  static TextStyle bodySmall(BuildContext context) => TextStyle(
        fontFamily: GlobalVariable.fontFamily,
        fontSize: 11.sp, // Adjust as necessary
        color: text_color,
      );

  // labels
  static TextStyle labelLarge(BuildContext context) => TextStyle(
        fontFamily: GlobalVariable.fontFamily,
        fontSize: 10.sp, // Adjust as necessary
        fontWeight: FontWeight.w500,
        color: text_color,
      );

  static TextStyle labelMedium(BuildContext context) => TextStyle(
        fontFamily: GlobalVariable.fontFamily,
        fontSize: 9.sp, // Adjust as necessary
        fontWeight: FontWeight.w500,
        color: text_color,
      );

  static TextStyle labelSmall(BuildContext context) => TextStyle(
        fontFamily: GlobalVariable.fontFamily,
        fontSize: 8.sp, // Adjust as necessary
        fontWeight: FontWeight.w500,
        color: text_color,
      );

  // others
  static TextStyle buttonStyle(BuildContext context) => TextStyle(
      fontFamily: GlobalVariable.fontFamily,
      fontSize: 15.sp, // Adjust as necessary
      fontWeight: FontWeight.w600,
      color: primary_text_color);

  static TextStyle errorStyle(BuildContext context) => TextStyle(
        fontFamily: GlobalVariable.fontFamily,
        fontSize: 10.sp,
        fontWeight: FontWeight.normal,
        color: Colors.red,
      );

  static TextStyle titleExtraSmall(BuildContext context) => TextStyle(
        fontFamily: GlobalVariable.fontFamily,
        fontSize: sizeHeight(context) / 85,
        fontWeight: FontWeight.w500,
        color: text_color,
      );
}
