// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:host_visitor_connect/common/custom_widget/dots_progress_button.dart';
import 'package:host_visitor_connect/common/res/styles.dart';
import 'package:host_visitor_connect/common/utils/utils.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class ConnectivityDialog {
  static late StreamSubscription subscription;
  static bool isDeviceConnected = false;
  static bool isAlertSet = false;

  static getConnectivity(BuildContext context) =>
      subscription = Connectivity().onConnectivityChanged.listen(
        (var result) async {
          isDeviceConnected = await InternetConnectionChecker().hasConnection;
          if (!isDeviceConnected && isAlertSet == false) {
            ConnectivityDialog.showDialogBox(context);
            isAlertSet = true;
          }
          if (isDeviceConnected && isAlertSet == true) {
            Navigator.pop(context);
            isAlertSet = false;
          }
        },
      );
  static showDialogBox(BuildContext context) {
    showDialog(
      useSafeArea: true,
      barrierDismissible: false,
      context: context,
      barrierColor: Colors.white,
      builder: (_) {
        return StatefulBuilder(builder: (context, setState) {
          return WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: AlertDialog(
              backgroundColor: Colors.white,
              elevation: 0,
              shadowColor: Colors.white,
              insetPadding: EdgeInsets.zero,
              content: SizedBox.expand(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Spacer(),
                    icon(context),
                    SizedBox(height: sizeHeight(context) / 80),
                    title(context),
                    SizedBox(height: sizeHeight(context) / 25),
                    desc(context),
                    const Spacer(),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: sizeHeight(context) / 80),
                            child: SizedBox(
                              child: DotsProgressButton(
                                isRectangularBorder: true,
                                child: Text(
                                  "TRY AGAIN",
                                  style: AppStyle.buttonStyle(context),
                                ),
                                onPressed: () async {
                                  Navigator.pop(context, 'Cancel');
                                  setState(() => isAlertSet = false);
                                  isDeviceConnected =
                                      await InternetConnectionChecker()
                                          .hasConnection;
                                  if (!isDeviceConnected &&
                                      isAlertSet == false) {
                                    ConnectivityDialog.showDialogBox(context);
                                    setState(() => isAlertSet = true);
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
      },
    );
  }

  static icon(BuildContext context) {
    return Icon(Icons.signal_wifi_statusbar_connected_no_internet_4_rounded,
        size: sizeHeight(context) / 4, color: Colors.blueGrey);
  }

  static title(BuildContext context) {
    return Text(
      "NO INTERNET \nCONNECTION",
      style: AppStyle.headlineMedium(context)
          .copyWith(fontWeight: FontWeight.w600, height: 1.1),
    );
  }

  static desc(BuildContext context) {
    return Text(
      "PLEASE CHECK YOUR \nINTERNET CONNECTION",
      textAlign: TextAlign.center,
      style: AppStyle.titleLarge(context).copyWith(
          letterSpacing: 3,
          fontFamily: "open_sans",
          color: Colors.black54,
          fontWeight: FontWeight.w300,
          height: 1.2),
    );
  }
}
