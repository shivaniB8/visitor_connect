// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/common/res/colors.dart';
import 'package:host_visitor_connect/common/res/keys.dart';
import 'package:host_visitor_connect/common/res/paths.dart';
import 'package:host_visitor_connect/common/shared_prefs.dart';
import 'package:host_visitor_connect/common/utils/route_generator.dart';
import 'package:host_visitor_connect/common/utils/utils.dart';
import 'package:host_visitor_connect/features/dashboard/bloc/user_details_bloc.dart';
import 'package:host_visitor_connect/features/dashboard/ui/home_page.dart';
import 'package:host_visitor_connect/features/login/ui/login_page.dart';
import 'package:host_visitor_connect/features/login/ui/login_provider.dart';
import 'package:host_visitor_connect/landingScreen/Widget/background.dart';
import 'package:host_visitor_connect/landingScreen/Widget/footerImage.dart';
import 'package:host_visitor_connect/landingScreen/landing_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    navigator();
    super.initState();
  }

  navigator() async {
    await Future.delayed(const Duration(milliseconds: 2000));
    SharedPrefs.getOnBoarding() == false
        ? Navigator.pushReplacement(
            context,
            goToRoute(
              const LandingScreen(),
            ),
            // MaterialPageRoute(
            //   builder: (context) => const LandingScreen(),
            // ),
          )
        : ((SharedPrefs.getString(apiAuthenticationToken) == null ||
                    SharedPrefs.getString(apiAuthenticationToken) == '') ||
                (context.read<UserDetailsBloc>().state.getData()?.userId ==
                    null))
            ? Navigator.pushReplacement(
                context,
                goToRoute(
                  const LoginProvider(child: LoginPage()),
                ),
                // MaterialPageRoute(
                //   builder: (context) => const LoginProvider(
                //     child: LoginPage(),
                //   ),
                // ),
              )
            : Navigator.pushReplacement(
                context,
                goToRoute(
                  const HomePage(),
                ),
                // MaterialPageRoute(
                //   builder: (context) => const HomePage(),
                // ),
              );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BackGroundWidget(
              image: "$images_path/splash2.png",
              backgroundColor: text_color.withOpacity(0.5)),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: sizeWidth(context) / 3,
                    decoration: const BoxDecoration(
                      color: primary_text_color,
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset(
                      "$images_path/splash_logo.png",
                    ),
                  ),
                  Image.asset(
                    "$images_path/Visitor-connect-final.png",
                    color: Colors.white,
                    fit: BoxFit.fitWidth,
                    height: sizeHeight(context) / 12,
                  )
                ],
              ),
            ),
          ),
          const Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0),
              child: FooterImage(
                image: "$images_path/goaElectronic.png",
              ),
            ),
          )
        ],
      ),
    );
  }
}
