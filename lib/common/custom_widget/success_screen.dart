import 'package:flutter/material.dart';
import 'package:host_visitor_connect/common/res/colors.dart';
import 'package:host_visitor_connect/common/res/paths.dart';
import 'package:host_visitor_connect/common/res/styles.dart';
import 'package:host_visitor_connect/common/utils/route_generator.dart';
import 'package:host_visitor_connect/features/dashboard/ui/home_page.dart';
import 'package:host_visitor_connect/features/login/ui/login_branch_screen.dart';
import 'package:host_visitor_connect/features/login/ui/login_page.dart';
import 'package:host_visitor_connect/features/login/ui/login_provider.dart';

class SuccessScreen extends StatelessWidget {
  static const routeName = 'success_screen';
  final String? title;
  final String? subtitle;
  final bool? isVisitor;
  final bool? isFromPasswordScreen;

  const SuccessScreen(
      {super.key,
      this.title,
      this.subtitle,
      this.isFromPasswordScreen,
      this.isVisitor});

  Future<bool> _onBackPressed() async {
    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Go Back',
        ),
        backgroundColor: Colors.white,
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (isVisitor ?? false) {
              Navigator.of(context).push(
                goToRoute(
                  const HomePage(),
                ),
              );
            } else if (isFromPasswordScreen ?? false) {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            } else {
              Navigator.of(context).popUntil((route) => route.isFirst);
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) =>
                      const LoginProvider(
                    child: LoginBranchScreen(),
                  ),
                ),
              );
            }
          },
        ),
      ),
      body: WillPopScope(
        onWillPop: _onBackPressed,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                '$icons_path/success.png',
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                title ?? 'Visitor Added Successfully',
                style: text_style_title3.copyWith(color: text_color),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 15,
              ),
              GestureDetector(
                  child: Text(
                    subtitle ?? 'Take me to Visitors List',
                    style: text_style_title11.copyWith(
                      color: buttonColor,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  onTap: () {
                    if (isVisitor ?? false) {
                      Navigator.of(context).push(
                        goToRoute(
                          const HomePage(),
                        ),
                        // MaterialPageRoute(
                        //   builder: (_) => const HomePage(),
                        // ),
                      );
                    } else if (isFromPasswordScreen ?? false) {
                      // Navigator.pushAndRemoveUntil(
                      //   context,
                      //   goToRoute(
                      //     const LoginProvider(
                      //       child: LoginPage(),
                      //     ),
                      //   ),
                      //   (route) => false,
                      // );
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    } else {
                      // Navigator.of(context).popUntil((route) => route.isFirst);
                      Navigator.push(
                        context,
                        goToRoute(
                          const LoginProvider(
                            child: LoginPage(),
                          ),
                        ),
                      );
                    }
                    // },
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
