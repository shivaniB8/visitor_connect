import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:host_visitor_connect/common/custom_widget/dots_progress_button.dart';
import 'package:host_visitor_connect/common/res/colors.dart';
import 'package:host_visitor_connect/common/res/styles.dart';

class WrongLocationWidget extends StatelessWidget {
  final String? buttonTitle;
  const WrongLocationWidget({super.key, this.buttonTitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
        child: Column(
          children: [
            Icon(
              Icons.wrong_location,
              color: primary_color,
              size: 50.sp,
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              'Your current location is not near by to the branch you have logged in.',
              style: AppStyle.titleMedium(context).copyWith(
                  fontWeight: FontWeight.w500, color: visitorNameColor),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              'You cannot add or scan visitor unless you are near to branch location',
              style: AppStyle.bodyMedium(context).copyWith(
                  fontWeight: FontWeight.w500, color: foreignerTextLabelColor),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 10.h,
            ),
            DotsProgressButton(
              isRectangularBorder: true,
              text: buttonTitle ?? 'Go Back',
              onPressed: () => Navigator.of(context).pop(),
              buttonBackgroundColor: Colors.green.shade400,
            ),
            SizedBox(
              height: 10.h,
            ),
          ],
        ),
      ),
    );
  }
}
