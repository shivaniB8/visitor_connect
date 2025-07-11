import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/common/custom_widget/widget/calling.dart';
import 'package:host_visitor_connect/common/custom_widget/widget/room_no.dart';
import 'package:host_visitor_connect/common/extensions/string_extensions.dart';
import 'package:host_visitor_connect/common/res/colors.dart';
import 'package:host_visitor_connect/common/res/keys.dart';
import 'package:host_visitor_connect/common/res/paths.dart';
import 'package:host_visitor_connect/common/res/styles.dart';
import 'package:host_visitor_connect/common/utils/utils.dart';
import 'package:host_visitor_connect/features/visitors/visitor_listing/blocs/virtual_numbers_bloc.dart';
import 'package:provider/provider.dart';
import 'model/report.dart';

class ListItemReport extends StatelessWidget {
  // final Report? reportHistory;
  final Report? report;
  final String? fullName;
  final String? reportDetails;
  final String? reportBy;
  final String? reportReason;
  final String? reportOn;
  final String? aadharPhoto;
  final String? visitorPhoto;
  final int? age;
  final int? gender;
  final int? visitorFk;
  final String? roomNo;
  final bool isReportHistory;
  const ListItemReport(
      {super.key,
      this.report,
      this.fullName,
      this.reportBy,
      this.reportReason,
      this.reportDetails,
      this.reportOn,
      this.aadharPhoto,
      this.visitorPhoto,
      this.gender,
      this.age,
      this.visitorFk,
      this.roomNo,
      this.isReportHistory = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 12),
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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              if (roomNo != null && roomNo != "")
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    RoomNumber(
                      roomNo: roomNo,
                    ),
                  ],
                ),
              Row(
                children: [
                  if ((aadharPhoto.isNullOrEmpty()) &&
                      (visitorPhoto.isNullOrEmpty()))
                    SizedBox(
                      width: sizeHeight(context) / 10,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(80),
                        child: Image.asset('$icons_path/avatar.png'),
                      ),
                    ),
                  if (!(aadharPhoto.isNullOrEmpty()) ||
                      !(visitorPhoto.isNullOrEmpty()))
                    CachedNetworkImage(
                      imageUrl: (visitorPhoto?.isNotEmpty ?? false)
                          ? '$googlePhotoUrl${getBucketName()}$voterPhotoFolder$visitorPhoto'
                          : '$googlePhotoUrl${getBucketName()}$visitorAadharFolder$aadharPhoto',
                      imageBuilder: (context, imageProvider) {
                        return Container(
                          height: sizeHeight(context) / 10,
                          width: sizeHeight(context) / 10,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                      placeholder: (context, url) => SizedBox(
                        height: sizeHeight(context) / 10,
                        width: sizeHeight(context) / 10,
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                      errorWidget: (context, url, error) => SizedBox(
                        width: sizeHeight(context) / 10,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(80),
                          child: Image.asset('$icons_path/avatar.png'),
                        ),
                      ),
                    ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          capitalizedString(fullName ?? "N/A"),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: AppStyle.titleSmall(context).copyWith(
                              fontWeight: FontWeight.w600,
                              color: visitorNameColor),
                        ),
                        SizedBox(width: sizeHeight(context) / 15),
                        Row(
                          children: [
                            Text(
                              "${report != null && age != null ? age.toString() : ""}"
                              "${report != null && gender != null ? "${age != null ? "," : ""} ${gender == 1 ? "M" : report?.gender == 2 ? "F" : report?.gender.toString() ?? ""}" : ""}",
                              style: AppStyle.bodyMedium(context),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Reported-on",
                            style: AppStyle.bodyMedium(context)
                                .copyWith(color: foreignerTextLabelColor),
                          ),
                          repotedWidget(
                              color: visitorNameColor,
                              context: context,
                              fontWeight: FontWeight.w400,
                              title: !reportOn.isNullOrEmpty()
                                  ? timeStampToDateAndTime(reportOn)
                                      .split(" ")[3]
                                  : 'N/A'),
                          Text(
                            reportOn != null && reportOn != ""
                                ? "${timeStampToDateAndTime(reportOn).split(" ")[0]} ${timeStampToDateAndTime(reportOn).split(" ")[1]}"
                                : "",
                            style: AppStyle.labelSmall(context).copyWith(
                                color: foreignerTextLabelColor,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(height: sizeHeight(context) / 150),
                          Text(
                            "Reported-by",
                            style: AppStyle.bodyMedium(context)
                                .copyWith(color: foreignerTextLabelColor),
                          ),
                          repotedWidget(
                              color: visitorNameColor,
                              context: context,
                              fontWeight: FontWeight.w400,
                              title: capitalizedString(reportBy.isNullOrEmpty()
                                  ? 'N/A'
                                  : reportBy ?? ""))
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 14.0),
                      width: 1,
                      color: const Color.fromARGB(255, 194, 194, 194),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Report-details",
                            style: AppStyle.bodyMedium(context)
                                .copyWith(color: foreignerTextLabelColor),
                          ),
                          repotedWidget(
                              color: visitorNameColor,
                              context: context,
                              fontWeight: FontWeight.w400,
                              title: capitalizedString(
                                  reportDetails.isNullOrEmpty()
                                      ? 'N/A'
                                      : reportDetails ?? "")),
                          SizedBox(height: sizeHeight(context) / 150),
                          Text(
                            "Report-reason",
                            style: AppStyle.bodyMedium(context)
                                .copyWith(color: foreignerTextLabelColor),
                          ),
                          repotedWidget(
                              color: visitorNameColor,
                              context: context,
                              fontWeight: FontWeight.w400,
                              title: capitalizedString(
                                  reportReason.isNullOrEmpty()
                                      ? 'N/A'
                                      : reportReason ?? ""))
                        ],
                      ),
                    ),
                    CallingWidget(
                        visitorId: visitorFk ?? 0,
                        settingId: context
                                .read<VirtualNumbersBloc>()
                                .state
                                .getData()
                                ?.records
                                ?.first
                                .settingId ??
                            0)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget repotedWidget(
      {String? title, Color? color, context, FontWeight? fontWeight}) {
    return Text(
      title ?? "N/A",
      overflow: TextOverflow.ellipsis,
      maxLines: isReportHistory ? 4 : 1,
      style: AppStyle.bodySmall(context)
          .copyWith(color: drawer_color1, fontWeight: FontWeight.w500),
    );
  }
}
