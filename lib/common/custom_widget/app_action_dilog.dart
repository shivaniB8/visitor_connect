import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:host_visitor_connect/common/custom_widget/dots_progress_button.dart';
import 'package:host_visitor_connect/common/extensions/string_extensions.dart';
import 'package:host_visitor_connect/common/res/colors.dart';
import 'package:host_visitor_connect/common/res/styles.dart';
import 'package:host_visitor_connect/common/utils/utils.dart';

class AppActionDialog {
  static void showActionDialog(
      {required BuildContext context,
      Color? color,
      bool? showOrangeCOlor,
      String? title,
      String? subtitle, // Added subtitle parameter
      String? positiveButtonText,
      String? negativeButtonText,
      Widget? child,
      String? image,
      bool? success,
      bool? warning,
      bool? showLeftSideButton}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (image != null)
                  Container(
                    decoration: BoxDecoration(
                      color: success == true
                          ? Colors.white
                          : color.toString() == "null" || color.toString() == ''
                              ? const Color(0xffFFD1D3)
                              : color?.withOpacity(0.4),
                      shape: BoxShape.circle,
                    ),
                    padding: EdgeInsets.all(success == true
                        ? 8
                        : warning == true
                            ? 8
                            : 15),
                    child: Image.asset(
                      image,
                      color: showOrangeCOlor ?? false ? Colors.amber : null,
                      height: success == true
                          ? sizeHeight(context) / 18
                          : warning == true
                              ? sizeHeight(context) / 18
                              : sizeHeight(context) / 25,
                    ),
                  ),
                SizedBox(height: sizeHeight(context) / 50),
                if (!(title.isNullOrEmpty()))
                  Text(
                    title ?? "Error Occured",
                    style: AppStyle.headlineSmall(context).copyWith(
                        fontWeight: FontWeight.w700, color: errorDiloagTitle),
                  ),
                if (!(title.isNullOrEmpty()))
                  SizedBox(height: sizeHeight(context) / 80),
                Text(
                  subtitle ?? "",
                  style: AppStyle.bodyMedium(context)
                      .copyWith(color: errorDiloagSubtitle),
                  textAlign: TextAlign.center,
                ),
              ],
            ), // Displaying the subtitle here
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (showLeftSideButton ?? false)
                    Expanded(
                      child: DotsProgressButton(
                        expanded: true,
                        textColor: lightBgColor,
                        text: negativeButtonText,
                        isRectangularBorder: true,
                        buttonBackgroundColor: const Color(0xffE7E7E7),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        textBackgroundColor: const Color(0xff707070),
                        child: Text(
                          negativeButtonText ?? '',
                          style: AppStyle.buttonStyle(context)
                              .copyWith(color: lightBgColor),
                        ),
                      ),
                    ),
                  if (showLeftSideButton ?? false)
                    SizedBox(
                      width: 10.w,
                    ),
                  Flexible(child: child ?? Container()),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
