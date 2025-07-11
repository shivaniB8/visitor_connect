import 'package:flutter/material.dart';
import 'package:host_visitor_connect/common/extensions/string_extensions.dart';
import 'package:host_visitor_connect/common/res/colors.dart';
import 'package:host_visitor_connect/common/res/styles.dart';
import 'package:host_visitor_connect/common/utils/utils.dart';
import 'package:host_visitor_connect/features/dashboard/data/network/responses/user_details_response.dart';
import 'package:host_visitor_connect/features/profile/ui/widget/imageWidget.dart';

class ProfileHead extends StatelessWidget {
  final UserDetailsResponse? userData;
  const ProfileHead({super.key, this.userData});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ImageWidget(profileImage: userData?.userPhoto),
        SizedBox(
          height: sizeHeight(context) / 130,
        ),
        Text(
         capitalizedString(userData?.fullName ?? ""),
          style: AppStyle.titleSmall(context)
              .copyWith(color: primary_text_color,fontWeight: FontWeight.w600),
        ),
        SizedBox(
          height: sizeHeight(context) / 90,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              capitalize(userData?.designation ?? ""),
              style: AppStyle.bodyMedium(context)
                  .copyWith(color: primary_text_color,fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              userData?.mobileNumber?.replaceRange(4, 8, "XXXX") ?? "",
              style: AppStyle.bodyMedium(context)
                  .copyWith(color: primary_text_color),
            ),
          ],
        )
      ],
    );
  }
}
