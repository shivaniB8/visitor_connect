import 'package:flutter/material.dart';
import 'package:host_visitor_connect/common/custom_widget/app_bar_widget/custom_widget_image_app_bar.dart';
import 'package:host_visitor_connect/common/custom_widget/dots_progress_button.dart';
import 'package:host_visitor_connect/common/res/colors.dart';
import 'package:host_visitor_connect/common/res/styles.dart';
import 'package:host_visitor_connect/common/utils/route_generator.dart';
import 'package:host_visitor_connect/common/utils/utils.dart';
import 'package:host_visitor_connect/features/dashboard/ui/home_page.dart';

class ConfirmAppScreen extends StatelessWidget {
  final String? title;

  final String? subtitle;

  final String img;
  final bool? isFromReportScreen;
  final bool? isFromVisitorEditScreen;
  final bool? showBackButton;
  final bool? isFromReportedListScreen;

  const ConfirmAppScreen({
    super.key,
    this.title,
    this.subtitle,
    required this.img,
    this.isFromReportScreen,
    this.isFromReportedListScreen,
    this.isFromVisitorEditScreen,
    this.showBackButton = true,
  });

  // ConfirmAppScreen(
  //    img: '$icons_path/done.png',
  //    title: 'Confirmation',
  //    subtitle:
  //       "Visitor Reported successfully",
  //    )
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: CustomImageAppBar(
          showBackButton: false,
          context: context,
          title: title ?? "",
          showSettings: false,
          showEditIcon: false,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
                    height: sizeHeight(context) / 20,
                  ),
                  Image.asset(
                    img,
                    height: sizeHeight(context) / 10,
                  ),
                  SizedBox(
                    height: sizeHeight(context) / 20,
                  ),
                  Text(
                    title ?? '',
                    style: AppStyle.headlineMedium(context).copyWith(
                        color: errorDiloagTitle, fontWeight: FontWeight.w600),
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: DotsProgressButton(
                              isRectangularBorder: true,
                              text: "Continue",
                              onPressed: () {
                                // if (isFromReportScreen ?? false) {
                                //   Navigator.pushAndRemoveUntil(
                                //     context,
                                //     goToRoute(
                                //       const ReportListProvider(
                                //           child: ReportScreen(
                                //         searchFilterState:
                                //             SearchFilterState.reportListSearch,
                                //       )),
                                //     ),
                                //     (route) {
                                //       return false;
                                //     },
                                //   );
                                // } else if (isFromVisitorEditScreen ?? false) {
                                //   Navigator.pushAndRemoveUntil(
                                //     context,
                                //     goToRoute(
                                //       const VisitorsListingProvider(
                                //         child: VisitorsScreen(
                                //           searchFilterState:
                                //               SearchFilterState.visitorSearch,
                                //         ),
                                //       ),
                                //     ),
                                //     (route) {
                                //       return false;
                                //     },
                                //   );
                                // } else {
                                Navigator.of(context).pushAndRemoveUntil(
                                    goToRoute(const HomePage()),
                                    (route) => false);
                              }
                              // },
                              ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: sizeHeight(context) / 35,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
