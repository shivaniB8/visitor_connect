import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:host_visitor_connect/common/custom_widget/widget/qrCode_dialog.dart';
import 'package:host_visitor_connect/common/res/keys.dart';
import 'package:host_visitor_connect/common/res/paths.dart';

class QRCodeWidget extends StatelessWidget {
  final String? qrImage;
  final bool? showShareButton;
  final double size;

  const QRCodeWidget(
      {super.key, this.qrImage, this.showShareButton, required this.size});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        QRCodeDialog.showQRCodeDialog(
            context: context,
            qrImage: qrImage,
            showShareButton: showShareButton);
      },
      child: CachedNetworkImage(
        imageUrl: '$googlePhotoUrl${getBucketName()}$qrCodeFolder$qrImage',
        fit: BoxFit.contain,
        width: size - 12,
        height: size - 12,
        placeholder: (context, url) => SizedBox(
          width: MediaQuery.of(context).size.width / 6,
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        ),
        errorWidget: (context, url, error) => SizedBox(
            width: MediaQuery.of(context).size.width / 6,
            child: Image.asset('$images_path/no_qrimage.png')),
      ),
    );
  }
}
