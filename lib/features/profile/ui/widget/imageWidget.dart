import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:host_visitor_connect/common/extensions/string_extensions.dart';
import 'package:host_visitor_connect/common/res/colors.dart';
import 'package:host_visitor_connect/common/res/keys.dart';
import 'package:host_visitor_connect/common/res/paths.dart';
import 'package:host_visitor_connect/common/utils/utils.dart';

class ImageWidget extends StatelessWidget {
  final String? profileImage;
  final String? aadharImage;
  const ImageWidget({
    super.key,
    this.profileImage,
    this.aadharImage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        height: sizeHeight(context) / 12,
        width: sizeHeight(context) / 12,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: primary_text_color, width: 2)),
        child: Column(
          children: [
            if ((aadharImage.isNullOrEmpty()) && (profileImage.isNullOrEmpty()))
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(sizeHeight(context) / 80),
                  child: Icon(
                    Icons.person,
                    color: primary_text_color,
                    size: sizeHeight(context) / 20,
                  ),
                ),
              ),
            if (!profileImage.isNullOrEmpty() || !aadharImage.isNullOrEmpty())
              Flexible(
                child: CachedNetworkImage(
                    fadeInDuration: const Duration(seconds: 0),
                    fadeOutDuration: const Duration(seconds: 0),
                    placeholderFadeInDuration: const Duration(seconds: 0),
                    imageUrl: !profileImage.isNullOrEmpty()
                        ? '$googlePhotoUrl${getBucketName()}$userPhoto$profileImage'
                        : '$googlePhotoUrl${getBucketName()}$visitorAadharFolder$aadharImage',
                    cacheKey: !profileImage.isNullOrEmpty()
                        ? '$googlePhotoUrl${getBucketName()}$userPhoto$profileImage'
                        : '$googlePhotoUrl${getBucketName()}$visitorAadharFolder$aadharImage',
                    imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                    placeholder: (context, url) => Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: sizeHeight(context) / 80,
                              vertical: sizeHeight(context) / 80),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: const CircularProgressIndicator(
                              strokeWidth: 2.5, color: primary_text_color),
                        ),
                    errorWidget: (context, url, error) => Padding(
                          padding: EdgeInsets.all(sizeHeight(context) / 80),
                          child: Icon(
                            Icons.person,
                            color: primary_text_color,
                            size: sizeHeight(context) / 20,
                          ),
                        )),
              ),
          ],
        ));
  }
}
