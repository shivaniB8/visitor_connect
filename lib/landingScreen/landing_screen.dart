// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:host_visitor_connect/common/res/colors.dart';
import 'package:host_visitor_connect/common/res/paths.dart';
import 'package:host_visitor_connect/common/res/styles.dart';
import 'package:host_visitor_connect/common/shared_prefs.dart';
import 'package:host_visitor_connect/common/utils/route_generator.dart';
import 'package:host_visitor_connect/common/utils/utils.dart';
import 'package:host_visitor_connect/features/login/ui/login_page.dart';
import 'package:host_visitor_connect/features/login/ui/login_provider.dart';
import 'package:host_visitor_connect/landingScreen/Widget/background.dart';
import 'package:host_visitor_connect/landingScreen/Widget/footerImage.dart';
import 'package:host_visitor_connect/landingScreen/Widget/headerImage.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Widget> _pages = [
    const OnboardingPage(
      imageLeft: "$images_path/goaPolice.png",
      imageRight: "$images_path/onboarding_logo.png",
      imageBottom: "$images_path/goaElectronic.png",
      backgroundImage: "$images_path/splash1.jpeg",
      title: 'Visitor Connect\n by Goa Police.',
    ),
    const OnboardingPage(
      imageLeft: "$images_path/goaPolice.png",
      imageRight: "$images_path/onboarding_logo.png",
      imageBottom: "$images_path/goaElectronic.png",
      backgroundImage: "$images_path/splash2.png",
      title: 'Visitor Connect\n by Goa Police.',
    ),
    const OnboardingPage(
      imageLeft: "$images_path/goaPolice.png",
      imageRight: "$images_path/onboarding_logo.png",
      imageBottom: "$images_path/goaElectronic.png",
      backgroundImage: "$images_path/splash3.jpg",
      title: 'Visitor Connect\n by Goa Police.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            // physics: const NeverScrollableScrollPhysics(),
            controller: _pageController,
            itemCount: _pages.length,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            itemBuilder: (context, index) {
              return _pages[index];
            },
          ),
          Positioned(
            bottom: sizeHeight(context) / 30,
            left: 20,
            right: 20,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: sizeHeight(context) / 45),
                  child: const FooterImage(
                    image: "$images_path/goaElectronic.png",
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: List.generate(
                        _pages.length,
                        (index) => _buildDot(index, context),
                      ),
                    ),
                    _currentPage == _pages.length - 1
                        ? TextButton(
                            onPressed: () {
                              SharedPrefs.setOnBoarding(true);
                              // Navigate to the main screen or perform any action
                              Navigator.pushAndRemoveUntil(
                                context,
                                goToRoute(
                                  const LoginProvider(
                                    child: LoginPage(),
                                  ),
                                ),
                                // MaterialPageRoute(
                                //     builder: (context) => const LoginProvider(
                                //           child: LoginPage(),
                                //         )),
                                (route) => false,
                              );
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Text('START',
                                      style: AppStyle.titleMedium(context)
                                          .copyWith(
                                              fontWeight: FontWeight.w600,
                                              color: primary_text_color)),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: primary_text_color,
                                  size: 20.sp,
                                ),
                              ],
                            ))
                        : TextButton(
                            onPressed: () {
                              _pageController.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.ease,
                              );
                              if (_currentPage == 2) {
                                SharedPrefs.setOnBoarding(true);
                              }
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Text('NEXT',
                                      style: AppStyle.titleMedium(context)
                                          .copyWith(
                                              fontWeight: FontWeight.w600,
                                              color: primary_text_color)),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: primary_text_color,
                                  size: 20.sp,
                                ),
                              ],
                            ),
                          ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDot(int index, BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      padding: const EdgeInsets.all(3),
      margin: EdgeInsets.only(left: 2, right: _currentPage == index ? 3 : 0),
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: _currentPage == index
              ? Border.all(
                  width: 1.5,
                  color: _currentPage == index
                      ? Colors.white
                      : const Color(0xff9F9F9F),
                )
              : null),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: Curves.linear,
        width: _currentPage == index
            ? sizeHeight(context) / 60
            : sizeHeight(context) / 55,
        height: _currentPage == index
            ? sizeHeight(context) / 60
            : sizeHeight(context) / 55,
        decoration: BoxDecoration(
          color: _currentPage == index ? Colors.white : const Color(0xff9F9F9F),
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String imageLeft;
  final String imageRight;
  final String imageBottom;
  final String backgroundImage;
  final String title;

  const OnboardingPage({
    super.key,
    required this.imageLeft,
    required this.imageRight,
    required this.imageBottom,
    required this.backgroundImage,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: text_color,
      body: SafeArea(
        child: Stack(
          children: [
            BackGroundWidget(
                image: backgroundImage,
                backgroundColor: text_color.withOpacity(.5)),
            Column(
              children: [
                SizedBox(
                  height: sizeHeight(context) / 20,
                ),
                HeaderImage(imageLeft: imageLeft, imageRight: imageRight),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: 15.0, top: sizeHeight(context) / 8),
                      child: middleText(context),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget middleText(BuildContext context) {
    return Text(
      title,
      style: AppStyle.headlineLarge(context)
          .copyWith(fontWeight: FontWeight.w600, color: primary_text_color),
    );
  }
}
