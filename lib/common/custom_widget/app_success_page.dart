import 'package:flutter/material.dart';
import 'package:host_visitor_connect/common/custom_widget/app_bar_widget/custom_widget_image_app_bar.dart';
import 'package:host_visitor_connect/common/custom_widget/dots_progress_button.dart';
import 'package:host_visitor_connect/common/res/colors.dart';
import 'package:host_visitor_connect/common/res/styles.dart';
import 'package:host_visitor_connect/common/utils/route_generator.dart';
import 'package:host_visitor_connect/common/utils/utils.dart';
import 'package:host_visitor_connect/features/dashboard/ui/home_page.dart';

class SuccessAppScreen extends StatelessWidget {
  static const routeName = 'success_screen';

  final String? title;

  final String? subtitle;

  final String img;

  final bool? showBackButton;

  const SuccessAppScreen({
    super.key,
    this.title,
    this.subtitle,
    required this.img,
    this.showBackButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomImageAppBar(
        showSettings: false,
        showEditIcon: false,
        showBackButton: showBackButton ?? true,
        context: context,
        title: "Congratulations",
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: sizeHeight(context) / 20,
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              border: Border.all(color: gray_color, width: 0.2),
              color: const Color(0x0ff2c2c2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: sizeHeight(context) / 15,
                ),
                Image.asset(
                  img,
                  height: sizeHeight(context) / 4.5,
                ),
                SizedBox(
                  height: sizeHeight(context) / 20,
                ),
                Text(
                  title ?? '',
                  style: AppStyle.headlineMedium(context).copyWith(
                      color: buttonColor, fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: sizeHeight(context) / 60,
                ),
                Text(
                  subtitle ?? '',
                  style: AppStyle.bodyLarge(context)
                      .copyWith(color: errorDiloagSubtitle),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: sizeHeight(context) / 24,
                ),
              ],
            ),
          ),
          SizedBox(
            height: sizeHeight(context) / 24,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: [
                Expanded(
                  child: DotsProgressButton(
                    isRectangularBorder: true,
                    text: "Continue",
                    onPressed: () {
                      Navigator.of(context).pushAndRemoveUntil(
                          goToRoute(const HomePage()), (route) => false);
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
