import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:host_visitor_connect/common/res/colors.dart';
import 'package:host_visitor_connect/common/res/styles.dart';
import 'package:host_visitor_connect/common/utils/route_generator.dart';
import 'package:host_visitor_connect/common/utils/utils.dart';
import 'package:host_visitor_connect/features/login/ui/forget_password.dart';
import 'package:host_visitor_connect/features/login/ui/forget_password_provider.dart';
import 'package:host_visitor_connect/generated/l10n.dart';

class ForgotPasswordWidget extends StatelessWidget {
  final String? phoneNumber;
  final bool? isEnable;

  const ForgotPasswordWidget({super.key, this.phoneNumber, this.isEnable});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          child: Text(
            S.of(context).loginPage_label_doNotRememberPassword,
            style: AppStyle.bodyLarge(context).copyWith(
                fontSize: sizeHeight(context) / 65,
                color: primary_text_color,
                fontWeight: FontWeight.w400),
          ),
        ),
        GestureDetector(
          child: Container(
            padding: EdgeInsets.symmetric(
                vertical: sizeHeight(context) / 110, horizontal: sizeHeight(context) / 70),
            decoration:
                BoxDecoration(color: profileTextColor, borderRadius: BorderRadius.circular(10)),
            child: Text(
              S.of(context).loginPage_label_forgotPassword,
              style: AppStyle.labelLarge(context).copyWith(
                  fontSize: sizeHeight(context) / 70,
                  color: primary_text_color,
                  fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
          ),
          onTap: () {
            Navigator.of(context).push(
              noSlideRoute(
                ForgetPasswordProviders(
                  child: ForgetPassword(
                    phoneNumber: phoneNumber,
                    isEnable: isEnable,
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
