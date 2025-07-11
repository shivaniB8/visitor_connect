import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:host_visitor_connect/common/res/colors.dart';
import 'package:host_visitor_connect/common/res/keys.dart';
import 'package:host_visitor_connect/common/res/paths.dart';
import 'package:host_visitor_connect/common/res/styles.dart';

class LoginImage extends StatelessWidget {
  final String? profileImage;
  const LoginImage({super.key, this.profileImage});

  @override
  Widget build(BuildContext context) {
    return profileImage == null || profileImage == ""
        ? Container(
            padding:
                EdgeInsets.all(appSize(context: context, unit: 10) / 12),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(width: 1.5, color: Colors.white)),
            child: Icon(
              Icons.person,
              color: Colors.white,
              size: appSize(context: context, unit: 10) / 6,
            ),
          )
        : CachedNetworkImage(
            fadeInDuration: const Duration(seconds: 0),
            fadeOutDuration: const Duration(seconds: 0),
            placeholderFadeInDuration: const Duration(seconds: 0),
            fit: BoxFit.cover,
            imageUrl:
                "$googlePhotoUrl${getBucketName()}$userPhoto$profileImage",
            cacheKey:
                "$googlePhotoUrl${getBucketName()}$userPhoto$profileImage",
            imageBuilder: (context, imageProvider) => Container(
              height: appSize(context: context, unit: 10) / 3,
              width: appSize(context: context, unit: 10) / 3,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: card_background_grey_color,
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            placeholder: (context, url) => Container(
              padding:
                  EdgeInsets.all(appSize(context: context, unit: 10) / 12),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(width: 1.5, color: Colors.white)),
              child: const CircularProgressIndicator(
                color: Colors.white,
              ),
            ),
            errorWidget: (context, url, error) => Container(
              padding:
                  EdgeInsets.all(appSize(context: context, unit: 10) / 12),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(width: 1.5, color: Colors.white)),
              child: Icon(
                Icons.person,
                color: Colors.white,
                size: appSize(context: context, unit: 10) / 6,
              ),
            ),
          );
  }
}
