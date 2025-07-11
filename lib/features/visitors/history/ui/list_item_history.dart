import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:host_visitor_connect/common/extensions/string_extensions.dart';
import 'package:host_visitor_connect/common/res/colors.dart';
import 'package:host_visitor_connect/common/res/keys.dart';
import 'package:host_visitor_connect/common/res/paths.dart';
import 'package:host_visitor_connect/common/res/styles.dart';
import 'package:host_visitor_connect/features/visitors/history/ui/model/history.dart';
import 'package:host_visitor_connect/features/visitors/visitor_listing/ui/model/visitor.dart';

class ListItemHistory extends StatelessWidget {
  final History? history;
  final Visitor? visitor;

  const ListItemHistory({
    super.key,
    this.history,
    this.visitor,
  });

  @override
  Widget build(BuildContext context) {
    print("visitor reson value ");
    print(history?.briefReason);
    print(history?.reasonFkValue);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
      child: Container(
        decoration: BoxDecoration(
          color: textFeildFillColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.grey.withOpacity(0.3),
            width: 0.5,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  if ((visitor?.aadharImage.isNullOrEmpty() ?? false) &&
                      (visitor?.image.isNullOrEmpty() ?? false))
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: SizedBox(
                        width: 45.h,
                        height: 45.h,
                        child: CircleAvatar(
                          radius: 35,
                          backgroundImage:
                              Image.asset('$icons_path/avatar.png').image,
                        ),
                      ),
                    ),
                  if (!(visitor?.aadharImage.isNullOrEmpty() ?? false) ||
                      !(visitor?.image.isNullOrEmpty() ?? false))
                    CachedNetworkImage(
                      imageUrl: (visitor?.image?.isNotEmpty ?? false)
                          ? '$googlePhotoUrl${getBucketName()}$voterPhotoFolder${visitor?.image}'
                          : '$googlePhotoUrl${getBucketName()}$visitorAadharFolder${visitor?.aadharImage}',
                      cacheKey: (visitor?.image?.isNotEmpty ?? false)
                          ? '$googlePhotoUrl${getBucketName()}$voterPhotoFolder${visitor?.image}'
                          : '$googlePhotoUrl${getBucketName()}$visitorAadharFolder${visitor?.aadharImage}',
                      imageBuilder: (context, imageProvider) {
                        return Container(
                          width: 45.h,
                          height: 45.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                      errorWidget: (context, url, error) => CircleAvatar(
                        backgroundImage:
                            Image.asset('$icons_path/avatar.png').image,
                      ),
                    ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          capitalizedString(history?.visitorFkValue ?? "N/A"),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppStyle.bodyLarge(context).copyWith(
                              fontWeight: FontWeight.w600,
                              color: visitorNameColor,
                              fontSize: 16),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          '${history?.hostFkValue ?? ''} (${history?.branchValue ?? 'N/A'})',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: AppStyle.bodyMedium(context),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Check-in",
                          style: AppStyle.bodyLarge(context)
                              .copyWith(color: foreignerTextLabelColor),
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        Text(
                          history?.entryDateTime != null &&
                                  history?.entryDateTime != ""
                              ? timeStampToDateAndTime(history?.entryDateTime)
                                  .split(" ")
                                  .first
                              : "--:--",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: AppStyle.bodyLarge(context).copyWith(
                              color: drawer_color1,
                              fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        Text(
                          history?.entryDateTime != null &&
                                  history?.entryDateTime != ""
                              ? "${timeStampToDateAndTime(history?.entryDateTime).split(" ")[1]} ${timeStampToDateAndTime(history?.entryDateTime).split(" ").last}"
                              : "",
                          style: AppStyle.labelSmall(context).copyWith(
                              fontSize: 10,
                              color: foreignerTextLabelColor,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 14.0),
                      width: 1,
                      color: const Color.fromARGB(255, 194, 194, 194),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Check-out",
                          style: AppStyle.bodyLarge(context)
                              .copyWith(color: foreignerTextLabelColor),
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        Text(
                          history?.exitDateTime != null &&
                                  history?.exitDateTime != ""
                              ? "${timeStampToDateAndTimeUTC(history?.exitDateTime).split(" ").first}"
                              : "--:--",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: AppStyle.bodyLarge(context).copyWith(
                              color: drawer_color1,
                              fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        Text(
                          history?.exitDateTime != null &&
                                  history?.exitDateTime != ""
                              ? "${timeStampToDateAndTimeUTC(history?.exitDateTime).split(" ")[1]} ${timeStampToDateAndTimeUTC(history?.exitDateTime).split(" ").last}"
                              : "",
                          style: AppStyle.labelSmall(context).copyWith(
                              fontSize: 10,
                              color: foreignerTextLabelColor,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 14.0),
                      width: 1,
                      color: const Color.fromARGB(255, 194, 194, 194),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Visiting Reason",
                            style: AppStyle.bodyLarge(context)
                                .copyWith(color: foreignerTextLabelColor),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            history?.reasonValue != null &&
                                    history?.reasonValue != ''
                                ? history?.reasonValue == "Other"
                                    ? history?.briefReason.toString() ?? ''
                                    : history?.reasonValue.toString() ?? ''
                                : 'N/A',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: AppStyle.bodyLarge(context).copyWith(
                                color: drawer_color1,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
