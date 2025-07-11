import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:host_visitor_connect/common/custom_widget/dots_progress_button.dart';
import 'package:host_visitor_connect/common/custom_widget/loading.dart';
import 'package:host_visitor_connect/common/custom_widget/title_bar_dialog.dart';
import 'package:host_visitor_connect/common/extensions/string_extensions.dart';
import 'package:host_visitor_connect/common/res/colors.dart';
import 'package:host_visitor_connect/common/res/keys.dart';
import 'package:host_visitor_connect/common/res/paths.dart';
import 'package:host_visitor_connect/common/res/styles.dart';
import 'package:host_visitor_connect/common/utils/app_function.dart';

class QRCodeDialog {
  static void showQRCodeDialog(
      {BuildContext? context, String? qrImage, bool? showShareButton}) {
    showDialog(
      context: context!,
      builder: (_) {
        return TitleBarDialog(
          headerTitle: 'Scan the QR code',
          bodyContent: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  'You can scan the QR code here',
                  style: AppStyle.bodyMedium(context).copyWith(
                      fontWeight: FontWeight.w500, color: visitorNameColor),
                ),
              ),
              if (!(qrImage.isNullOrEmpty()))
                Expanded(
                  child: CachedNetworkImage(
                    imageUrl:
                        '$googlePhotoUrl${getBucketName()}$qrCodeFolder$qrImage',
                    cacheKey:
                        '$googlePhotoUrl${getBucketName()}$qrCodeFolder$qrImage',
                    fit: BoxFit.cover,
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    placeholder: (context, url) => const LoadingWidget(),
                    errorWidget: (context, url, error) => Image.asset(
                      '$images_path/no_qrimage.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              SizedBox(
                height: 10.h,
              ),
              if (showShareButton == true && !qrImage.isNullOrEmpty())
                Padding(
                  padding: EdgeInsets.only(bottom: 8.h),
                  child: DotsProgressButton(
                    text: 'Share QR',
                    onPressed: () {
                      AppFunctions.shareQRImage(
                          '$googlePhotoUrl${getBucketName()}$qrCodeFolder$qrImage');
                    },
                  ),
                )
            ],
          ),
        );
      },
    );
  }
}
