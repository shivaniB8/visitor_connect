import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:host_visitor_connect/common/custom_widget/app_bottomsheet.dart';
import 'package:host_visitor_connect/common/res/colors.dart';
import 'package:host_visitor_connect/common/res/keys.dart';
import 'package:host_visitor_connect/common/utils/route_generator.dart';
import 'package:host_visitor_connect/features/login/ui/login_page.dart';
import 'package:host_visitor_connect/features/login/ui/login_provider.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class AppFunctions {
  static void unFocus(BuildContext context) {
    if (FocusScope.of(context).hasFocus) {
      FocusScope.of(context).unfocus();
    }
  }

  static Future<void> shareQRImage(String qrImageUrl) async {
    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/qr-code.png');

    // Download the QR image from the URL
    final response = await http.get(Uri.parse(qrImageUrl));
    if (response.statusCode == 200) {
      // Write the downloaded image data to a file
      await file.writeAsBytes(response.bodyBytes, flush: true);

      // Share the image file
      await Share.shareFiles(
        [file.path],
        subject: 'QR Code',
        mimeTypes: ['image/png'],
      );
    } else {
      throw Exception('Failed to download QR image: ${response.statusCode}');
    }
  }

  static String formatDate(date) {
    var parsedDate = DateTime.parse(date);
    // var formatted= DateFormat("dd-mm-yyyy").parse(date);
    var formattedDate =
        "${parsedDate.day}/${parsedDate.month.toString().length < 2 ? "0${parsedDate.month}" : parsedDate.month}/${parsedDate.year}";
    return formattedDate.toString();
  }

  static void unAuthorizedEntry(bool mounted) {
    Future.delayed(const Duration(milliseconds: 1000), () {
      final context = navigatorKey.currentContext;
      if (context != null) {
        AppBottomSheet.showAppSnackBar(
          context: context,
          text: "Session Expired",
          snackBarBGColor: primary_color,
          textColor: Colors.white,
        );
        if (!mounted) return;
        Navigator.pushAndRemoveUntil(
            context, goToRoute(const LoginProvider(child: LoginPage())), (route) => false);
      }
    });
  }
}
