import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:host_visitor_connect/common/constant/globalVariable.dart';
import 'package:host_visitor_connect/common/custom_widget/widget/qrCode.dart';
import 'package:host_visitor_connect/common/custom_widget/widget/room_no.dart';
import 'package:host_visitor_connect/common/extensions/string_extensions.dart';
import 'package:host_visitor_connect/common/res/colors.dart';
import 'package:host_visitor_connect/common/res/keys.dart';
import 'package:host_visitor_connect/common/res/paths.dart';
import 'package:host_visitor_connect/common/res/styles.dart';
import 'package:host_visitor_connect/common/utils/utils.dart';
import 'package:host_visitor_connect/features/dashboard/bloc/user_details_bloc.dart';
import 'package:host_visitor_connect/common/custom_widget/widget/calling.dart';
import 'package:host_visitor_connect/features/visitors/visitor_listing/blocs/check_out_bloc.dart';
import 'package:host_visitor_connect/features/visitors/visitor_listing/blocs/virtual_numbers_bloc.dart';
import 'package:host_visitor_connect/features/visitors/visitor_listing/ui/check_out_dialog_box.dart';
import 'package:host_visitor_connect/features/visitors/visitor_listing/ui/check_out_visitors_builder.dart';
import 'package:host_visitor_connect/features/visitors/visitor_listing/ui/model/check_out_model.dart';
import 'package:host_visitor_connect/features/visitors/visitor_listing/ui/model/visitor.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:host_visitor_connect/common/extensions/string_extensions.dart'
    as StringExtensions;

class ListItemVisitor extends StatefulWidget {
  final Room? room;
  final Visitor? visitor;
  final bool? isFromReportScreen;
  final int? selectedIdx;
  final int? index;
  final int? visitorLength;
  final String? roomNo;
  final bool? showCheckoutButton;
  final bool? selectedIndex;
  final ScrollController? visitorListScrollController;
  final bool? isFromCurrentVisitors;
  final bool? isFromMainList;
  final bool? isFromSearchVisitor;
  final String? businessType;
  final CheckOutVisitor? checkOutVisitor;

  const ListItemVisitor(
      {super.key,
      this.visitor,
      this.room,
      this.isFromReportScreen,
      this.selectedIdx,
      this.index,
      this.showCheckoutButton,
      this.roomNo,
      this.visitorLength,
      this.visitorListScrollController,
      this.selectedIndex,
      this.isFromCurrentVisitors,
      this.isFromMainList,
      this.isFromSearchVisitor,
      this.businessType,
      this.checkOutVisitor});

  @override
  State<ListItemVisitor> createState() => _ListItemVisitorState();
}

class _ListItemVisitorState extends State<ListItemVisitor> {
  @override
  Widget build(BuildContext context) {
    double imgSize = appSize(context: context, unit: 10) / 4;
    double fontSize = appSize(context: context, unit: 10) / 14;
    String visaNumber = widget.visitor?.visaNumber ?? '';
    String maskedVisaNumber = visaNumber.length >= 3
        ? visaNumber.substring(visaNumber.length - 3)
        : '';

    final userDetails = context.read<UserDetailsBloc>().state.getData();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
      child: Container(
        decoration: widget.isFromReportScreen ?? false
            ? BoxDecoration(
                color: widget.selectedIdx == widget.index
                    ? list_selected_color
                    : list_card_color,
                borderRadius: BorderRadius.circular(20),
              )
            : BoxDecoration(
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
              if (widget.visitor?.roomNo != null &&
                  widget.visitor?.roomNo != "")
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    RoomNumber(
                      businessType: widget.businessType,
                      roomNo: widget.visitor?.roomNo,
                    ),
                  ],
                ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if ((widget.visitor?.aadharImage.isNullOrEmpty() ?? false) &&
                      (widget.visitor?.image.isNullOrEmpty() ?? false))
                    Padding(
                      padding: EdgeInsets.only(right: 8.h),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width / 6,
                        child: Stack(
                          children: [
                            CircleAvatar(
                              radius: 35.sp,
                              backgroundImage:
                                  Image.asset('$icons_path/avatar.png').image,
                            ),
                            if ((widget.visitorLength ?? 0) > 1 &&
                                (widget.isFromMainList ?? false))
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  width: imgSize - 33,
                                  height: imgSize - 33,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                  ),
                                  child: Center(
                                    child: Text(
                                      "+${(widget.visitorLength ?? 0) - 1}",
                                      style: TextStyle(
                                        color: foreignerTextLabelColor,
                                        fontSize: fontSize - 5,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  if (!(widget.visitor?.aadharImage.isNullOrEmpty() ?? false) ||
                      !(widget.visitor?.image.isNullOrEmpty() ?? false))
                    SizedBox(
                      // height: 50.h,
                      // width: 50.h,
                      child: Stack(
                        alignment: Alignment.centerLeft,
                        children: [
                          Visibility(
                            visible: (widget.visitorLength ?? 0) > 1,
                            child: CachedNetworkImage(
                              imageUrl: (widget.visitor?.image?.isNotEmpty ??
                                      false)
                                  ? '$googlePhotoUrl${getBucketName()}$voterPhotoFolder${widget.visitor?.image}'
                                  : '$googlePhotoUrl${getBucketName()}$visitorAadharFolder${widget.visitor?.aadharImage}',
                              cacheKey: (widget.visitor?.image?.isNotEmpty ??
                                      false)
                                  ? '$googlePhotoUrl${getBucketName()}$voterPhotoFolder${widget.visitor?.image}'
                                  : '$googlePhotoUrl${getBucketName()}$visitorAadharFolder${widget.visitor?.aadharImage}',
                              imageBuilder: (context, imageProvider) {
                                return Container(
                                  width: imgSize + 18,
                                  height: imgSize,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 1,
                                    ),
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                );
                              },
                              errorWidget: (context, url, error) =>
                                  CircleAvatar(
                                backgroundImage:
                                    Image.asset('$icons_path/avatar.png').image,
                              ),
                            ),
                          ),

                          CachedNetworkImage(
                            imageUrl: (widget.visitor?.image?.isNotEmpty ??
                                    false)
                                ? '$googlePhotoUrl${getBucketName()}$voterPhotoFolder${widget.visitor?.image}'
                                : '$googlePhotoUrl${getBucketName()}$visitorAadharFolder${widget.visitor?.aadharImage}',
                            cacheKey: (widget.visitor?.image?.isNotEmpty ??
                                    false)
                                ? '$googlePhotoUrl${getBucketName()}$voterPhotoFolder${widget.visitor?.image}'
                                : '$googlePhotoUrl${getBucketName()}$visitorAadharFolder${widget.visitor?.aadharImage}',
                            imageBuilder: (context, imageProvider) {
                              return Stack(
                                children: [
                                  Container(
                                    width: imgSize,
                                    height: imgSize,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 1,
                                      ),
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  if (!(widget.isFromReportScreen ?? false))
                                    Positioned(
                                      bottom: 0,
                                      right: 0,
                                      child: ((widget.visitorLength ?? 0) > 1 &&
                                              (widget.isFromMainList ?? false))
                                          ? Container(
                                              width: imgSize - 33,
                                              height: imgSize - 33,
                                              decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.white,
                                              ),
                                              child: Center(
                                                child: Text(
                                                  "+${(widget.visitorLength ?? 0) - 1}",
                                                  style: TextStyle(
                                                    color:
                                                        foreignerTextLabelColor,
                                                    fontSize: fontSize - 5,
                                                  ),
                                                ),
                                              ),
                                            )
                                          : const SizedBox.shrink(),
                                    ),
                                ],
                              );
                            },
                            placeholder: (context, url) => SizedBox(
                              width: MediaQuery.of(context).size.width / 6,
                              child: const Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                            errorWidget: (context, url, error) => SizedBox(
                              width: MediaQuery.of(context).size.width / 6,
                              child: CircleAvatar(
                                radius: 35.sp,
                                backgroundImage:
                                    Image.asset('$icons_path/avatar.png').image,
                              ),
                            ),
                          ),
                          // Positioned widget added to shift the first image to the right
                        ],
                      ),
                    ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          capitalizedString(widget.visitor?.shortName ??
                              widget.visitor?.fullName ??
                              "N/A"),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppStyle.bodyLarge(context).copyWith(
                              fontWeight: FontWeight.w600,
                              color: visitorNameColor,
                              fontSize: fontSize),
                        ),
                        SizedBox(height: sizeHeight(context) / 300),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${widget.visitor?.age?.toString() ?? ""}${widget.visitor?.age == null && widget.visitor?.gender == null || widget.visitor?.age == 0 && widget.visitor?.gender == 0 ? "" : ","}"
                                    " ${widget.visitor?.gender != null ? widget.visitor?.gender == 0 ? "" : widget.visitor?.gender == 1 ? "M" : widget.visitor?.gender == 2 ? "F" : widget.visitor?.gender.toString() ?? "" : ""}",
                                    style: AppStyle.bodyMedium(context)
                                        .copyWith(fontSize: fontSize - 4),
                                  ),
                                  const SizedBox(width: 5),
                                  if (widget.visitor?.visitorType == 1)
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 3.0),
                                      child: Icon(
                                        Icons.check_circle_rounded,
                                        color: checkCircleColor,
                                        size: sizeHeight(context) / 50,
                                      ),
                                    ),
                                  Flexible(
                                    child: Text(
                                      widget.visitor?.visitorType == 1
                                          ? widget.visitor?.aadharNo
                                                      .isNullOrEmpty() ??
                                                  false
                                              ? ""
                                              : "Aadhaar - ${widget.visitor?.aadharNo?.replaceRange(0, 9, "*") ?? 'N/A'}"
                                          : widget.visitor?.visaNumber
                                                      .isNullOrEmpty() ??
                                                  false
                                              ? ""
                                              : "Visa - ${maskedVisaNumber.isNotEmpty ? "*$maskedVisaNumber" : 'N/A'}",
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: AppStyle.bodyMedium(context)
                                          .copyWith(fontSize: fontSize - 4),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (!(widget.visitor?.qrImage.isNullOrEmpty() ??
                                false))
                              QRCodeWidget(
                                qrImage: widget.visitor?.qrImage,
                                size: imgSize,
                                showShareButton: true,
                              ),
                            if (!(widget.visitor?.qrImage.isNullOrEmpty() ??
                                false))
                              const SizedBox(width: 6)
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: sizeHeight(context) / 200),
              IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 3.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "State",
                                style: AppStyle.bodyLarge(context).copyWith(
                                  color: foreignerTextLabelColor,
                                  fontSize: fontSize - 2.7,
                                ),
                              ),

                              ///TODO change name
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.3,
                                child: Text(
                                  capitalizedString(
                                      widget.visitor?.state ?? 'N/A'),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppStyle.bodyLarge(context).copyWith(
                                    color: primary_color,
                                    fontSize: fontSize - 2.7,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                "City",
                                style: AppStyle.bodyLarge(context).copyWith(
                                  color: foreignerTextLabelColor,
                                  fontSize: fontSize - 2.7,
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.3,
                                child: Text(
                                  capitalizedString(
                                      widget.visitor?.city ?? 'N/A'),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppStyle.bodyLarge(context).copyWith(
                                    color: primary_color,
                                    fontSize: fontSize - 2.7,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Pincode",
                                style: AppStyle.bodyLarge(context).copyWith(
                                  color: foreignerTextLabelColor,
                                  fontSize: fontSize - 2.7,
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.3,
                                child: Text(
                                  capitalizedString(
                                      widget.visitor?.pincode ?? 'N/A'),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppStyle.bodyLarge(context).copyWith(
                                    color: primary_color,
                                    fontSize: fontSize - 2.7,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
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
                            widget.businessType == null
                                ? "Check In"
                                : "Rented On",
                            style: AppStyle.bodyLarge(context).copyWith(
                                color: foreignerTextLabelColor,
                                fontSize: fontSize - 2.7),
                          ),
                          Text(
                            widget.visitor?.entryDate != null &&
                                    widget.visitor?.entryDate != ""
                                // ? "${timeStampToDateAndTime(widget.visitor?.entryDate)}"
                                ? timeStampToDateAndTime(
                                        widget.visitor?.entryDate)
                                    .split(" ")
                                    .first
                                : "N/A",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: AppStyle.bodySmall(context).copyWith(
                                color: drawer_color1,
                                fontSize: fontSize - 2.7,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            widget.visitor?.entryDate != null &&
                                    widget.visitor?.entryDate != ""
                                ? "${timeStampToDateAndTime(widget.visitor?.entryDate).split(" ")[1]} ${timeStampToDateAndTime(widget.visitor?.entryDate).split(" ").last}"
                                : "",
                            style: AppStyle.labelSmall(context).copyWith(
                                fontSize: 10,
                                color: foreignerTextLabelColor,
                                fontWeight: FontWeight.w500),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              widget.isFromSearchVisitor ?? false
                                  ? const SizedBox.shrink()
                                  : widget.visitor?.visitorExitDate == null ||
                                          widget.visitor?.visitorExitDate == ""
                                      ? _checkOutBtn(context, userDetails)
                                      : SizedBox.shrink(),
                              if (widget.visitor?.visitorExitDate != null &&
                                  widget.visitor?.visitorExitDate != "")
                                Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Text(
                                    widget.businessType == null
                                        ? "Checkout"
                                        : "Returned On",
                                    style: AppStyle.bodyLarge(context).copyWith(
                                        color: foreignerTextLabelColor),
                                  ),
                                ),

                              Column(
                                children: [
                                  if (widget.visitor?.visitorExitDate != null &&
                                      widget.visitor?.visitorExitDate != "")
                                    Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Text(
                                        (widget.visitor?.visitorExitDate !=
                                                    null &&
                                                widget.visitor
                                                        ?.visitorExitDate !=
                                                    "")
                                            // ? "${DateTime.fromMillisecondsSinceEpoch(int.tryParse(widget.visitor?.visitorExitDate ?? "") ?? 0)}"
                                            /// ONLY checkout date time shown in utc
                                            ? "${timeStampToDateAndTimeUTC(widget.visitor?.visitorExitDate).split(" ").first}"
                                            // ? "${widget.visitor?.visitorExitDate?.split(" ").first.split("-").reversed.join("-")}"
                                            : "--:--",
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: AppStyle.bodySmall(context)
                                            .copyWith(
                                                color: drawer_color1,
                                                fontSize: fontSize - 2.7,
                                                fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Text(
                                      widget.visitor?.visitorExitDate != null &&
                                              widget.visitor?.visitorExitDate !=
                                                  ""
                                          // ? "${widget.visitor?.visitorExitDate}"
                                          ? "${timeStampToDateAndTimeUTC(widget.visitor?.visitorExitDate).split(" ")[1]} ${timeStampToDateAndTime(widget.visitor?.visitorExitDate).split(" ").last}"
                                          : "",
                                      style: AppStyle.labelSmall(context)
                                          .copyWith(
                                              fontSize: 10,
                                              color: foreignerTextLabelColor,
                                              fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ],
                              ),
                              // const SizedBox(height: 5),
                              // Text(
                              //   "${timeStampToDateAndTime(widget.visitor?.visitorExitDate).split(" ")[0]} ${timeStampToDateAndTime(widget.visitor?.visitorExitDate).split(" ")[1]}",
                              //   style: AppStyle.labelSmall(context).copyWith(
                              //       color: foreignerTextLabelColor, fontWeight: FontWeight.w500),
                              // ),
                            ],
                          )
                        ],
                      ),
                    ),
                    if (context
                            .read<VirtualNumbersBloc>()
                            .state
                            .getData()
                            ?.records
                            ?.isNotEmpty ??
                        false)
                      CallingWidget(
                          visitorId: widget.visitor?.visitorFk ?? 0,
                          settingId: (context
                                      .read<VirtualNumbersBloc>()
                                      .state
                                      .getData()
                                      ?.records
                                      ?.isEmpty ??
                                  false)
                              ? 0
                              : context
                                      .read<VirtualNumbersBloc>()
                                      .state
                                      .getData()
                                      ?.records
                                      ?.first
                                      .settingId ??
                                  0),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _checkOutBtn(BuildContext cnt, userDetails) => GestureDetector(
        onTap: !(widget.visitor?.visitorExitDate.isNullOrEmpty() ?? false)
            ? null
            : () {
                showDialog(
                  context: cnt,
                  builder: (cnt) {
                    return MultiProvider(
                      providers: [
                        BlocProvider.value(
                          value: context.read<CheckOutBloc>(),
                        ),
                        ChangeNotifierProvider.value(
                          value: context.read<CheckOutVisitor>(),
                        ),
                      ],
                      child: CheckOutDialogBox(
                        heading: checkOut(userDetails?.branchCategory),
                        confirmationText:
                            checkOutMessage(userDetails?.branchCategory),
                        child: CheckOutVisitorBuilder(
                          onSuccess: () async {
                            Navigator.pop(context);
                            if (!(widget.isFromMainList ?? true)) {
                              Navigator.pop(context);
                            }
                            if (widget.businessType == null) {
                              if (widget.isFromCurrentVisitors ?? false) {
                                GlobalVariable.callBackCurrentVisitorsList();
                              } else {
                                GlobalVariable.callBackVisitorsList();
                              }
                            } else {
                              GlobalVariable.callBackRentedList();
                            }
                          },
                          onCheckOutPressed: () async {
                            print("checkoutDate");
                            print(DateFormat('HH:mm').format(DateTime.now()));
                            print(context
                                .read<CheckOutVisitor>()
                                .checkOutTime
                                .toString());
                            String formattedDate = context
                                        .read<CheckOutVisitor>()
                                        .checkOutDate ==
                                    null
                                ? context.read<CheckOutVisitor>().checkOutDate =
                                    DateFormat('yyyy-MM-dd')
                                        .format(DateTime.now())
                                : context
                                    .read<CheckOutVisitor>()
                                    .checkOutDate
                                    .toString();
                            String formattedTime = context
                                        .read<CheckOutVisitor>()
                                        .checkOutTime ==
                                    null
                                ? context.read<CheckOutVisitor>().checkOutTime =
                                    DateFormat('HH:mm').format(DateTime.now())
                                : context
                                    .read<CheckOutVisitor>()
                                    .checkOutTime
                                    .toString();
                            // print("date time ");
                            // print(formattedTime);
                            // print(formattedDate);
                            context.read<CheckOutBloc>().visitorCheckout(
                                checkOutDate: formattedDate,
                                checkOutTime: formattedTime,
                                visitorId: widget.visitor?.id ?? 0);
                          },
                        ),
                      ),
                    );
                  },
                );
              },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: (widget.visitor?.visitorExitDate.isNullOrEmpty() ?? false)
                ? buttonColor
                : disabled_color,
          ),
          child: Text(
            (widget.visitor?.visitorExitDate.isNullOrEmpty() ?? false)
                ? widget.businessType == null
                    ? "${checkOut(userDetails?.branchCategory)}"
                    : "Return"
                : widget.businessType == null
                    ? "Checked Out"
                    : "Returned",
            textAlign: TextAlign.center,
            style: AppStyle.bodySmall(context).copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: sizeHeight(context) / 80),
          ),
        ),
      );
}
