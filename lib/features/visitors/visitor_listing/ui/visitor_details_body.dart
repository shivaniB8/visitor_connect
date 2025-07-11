import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:host_visitor_connect/common/custom_widget/widget/calling.dart';
import 'package:host_visitor_connect/common/extensions/number_extensions.dart';
import 'package:host_visitor_connect/common/custom_widget/fields/form_field_label.dart';
import 'package:host_visitor_connect/common/extensions/string_extensions.dart';
import 'package:host_visitor_connect/common/res/colors.dart';
import 'package:host_visitor_connect/common/res/keys.dart';
import 'package:host_visitor_connect/common/res/paths.dart';
import 'package:host_visitor_connect/common/res/styles.dart';
import 'package:host_visitor_connect/common/utils/location.dart';
import 'package:host_visitor_connect/features/visitors/visitor_listing/blocs/virtual_numbers_bloc.dart';
import 'package:host_visitor_connect/features/visitors/visitor_listing/ui/model/visitor.dart';
import 'package:host_visitor_connect/features/visitors/visitor_listing/ui/visitor_details.dart';
import 'package:provider/provider.dart';

class VisitorDetailsBody extends StatefulWidget {
  final Visitor? visitor;
  final bool? isReported;
  final bool? isFromCurrentVisitors;
  final String? businessType;

  const VisitorDetailsBody({
    super.key,
    this.visitor,
    this.isReported,
    this.isFromCurrentVisitors,
    this.businessType,
  });

  @override
  State<VisitorDetailsBody> createState() => _VisitorDetailsBodyState();
}

class _VisitorDetailsBodyState extends State<VisitorDetailsBody> {
  Position? currentPosition;

  @override
  void initState() {
    getCurrentLocation(location: (location) {
      currentPosition = location;
    });
    super.initState();
  }

  Widget getFeild({
    Widget? child,
    String? label,
    String? value,
    bool? isMobile,
    int? maxlines,
  }) {
    double vertPadding = appSize(context: context, unit: 10) / 25;
    return child ??
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FormFieldLabel(
              label: label,
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: textFeildFillColor,
                      border: Border.all(
                          color: Colors.grey.withOpacity(0.3), width: 0.5),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: vertPadding, horizontal: 10),
                        child: Row(
                          children: [
                            if ((widget.visitor?.mobileCountyCode?.isNotEmpty ??
                                false))
                              Text(widget.visitor?.mobileCountyCode ?? '+91')
                            else
                              const SizedBox(
                                width: 10,
                              ),
                            if ((widget.visitor?.mobileCountyCode?.isNotEmpty ??
                                false))
                              const SizedBox(
                                height: 20,
                                // Set an explicit height for the vertical divider
                                child: VerticalDivider(
                                  color: Colors.black,
                                  thickness: 1,
                                ),
                              ),
                            Expanded(
                              child: Text(
                                value ?? '',
                                maxLines: maxlines,
                                // overflow: TextOverflow.ellipsis,
                              ),
                              // const Spacer(),
                              // if (isMobile ?? false)
                              // CallingWidget(
                              //     visitorId: widget.visitor?.visitorFk ?? 0,
                              //     settingId: context
                              //             .read<VirtualNumbersBloc>()
                              //             .state
                              //             .getData()
                              //             ?.records
                              //             ?.first
                              //             .settingId ??
                              //         0),
                            ),
                          ],
                        )),
                  ),
                ),
                if ((isMobile ?? false) &&
                    (context
                            .read<VirtualNumbersBloc>()
                            .state
                            .getData()
                            ?.records
                            ?.isNotEmpty ??
                        false))
                  const SizedBox(
                    width: 10,
                  ),
                if ((isMobile ?? false) &&
                    (context
                            .read<VirtualNumbersBloc>()
                            .state
                            .getData()
                            ?.records
                            ?.isNotEmpty ??
                        false))
                  CallingWidget(
                    horizontalPadding: 1,
                    verticalPadding: vertPadding,
                    circularRadius: 8,
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
                            0,
                  ),
              ],
            ),
          ],
        );
  }

  @override
  Widget build(BuildContext context) {
    print("mobileCountyCode");
    print(widget.visitor?.mobileCountyCode.toString());
    String visaNumber = widget.visitor?.visaNumber ?? '';
    String maskedVisaNumber = visaNumber.length >= 3
        ? visaNumber.substring(visaNumber.length - 3)
        : '';
    String passportNumber = widget.visitor?.passportNo ?? '';
    String maskedPassportNumber = passportNumber.length >= 3
        ? passportNumber.substring(passportNumber.length - 3)
        : '';
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if ((widget.visitor?.aadharImage.isNullOrEmpty() ?? false) &&
                  (widget.visitor?.image.isNullOrEmpty() ?? false))
                SizedBox(
                  width: appSize(context: context, unit: 10) / 2,
                  height: appSize(context: context, unit: 10) / 2,
                  child: CircleAvatar(
                    backgroundImage:
                        Image.asset('$icons_path/avatar.png').image,
                  ),
                ),
              if (!(widget.visitor?.aadharImage.isNullOrEmpty() ?? false) ||
                  !(widget.visitor?.image.isNullOrEmpty() ?? false))
                CachedNetworkImage(
                  imageUrl: !(widget.visitor?.image.isNullOrEmpty() ?? false)
                      ? '$googlePhotoUrl${getBucketName()}$voterPhotoFolder${widget.visitor?.image}'
                      : '$googlePhotoUrl${getBucketName()}$visitorAadharFolder${widget.visitor?.aadharImage}',
                  imageBuilder: (context, imageProvider) {
                    return Container(
                      width: appSize(context: context, unit: 10) / 2,
                      height: appSize(context: context, unit: 10) / 2,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                  placeholder: (context, url) => SizedBox(
                    width: MediaQuery.of(context).size.width / 6,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                  errorWidget: (context, url, error) => SizedBox(
                    width: appSize(context: context, unit: 10) / 2,
                    height: appSize(context: context, unit: 10) / 2,
                    child: CircleAvatar(
                      backgroundImage:
                          Image.asset('$icons_path/avatar.png').image,
                    ),
                  ),
                ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  children: [
                    getFeild(
                      label: 'Full Name',
                      isMobile: false,
                      value: capitalizedString(
                        widget.visitor?.fullName ?? 'Not Available',
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    getFeild(
                      isMobile: true,
                      label: 'Mobile Number',
                      value: widget.visitor?.visitorType == 1 &&
                              !(widget.visitor?.mobileNo.isNullOrEmpty() ??
                                  false)
                          ? widget.visitor?.mobileNo?.replaceRange(
                                  1,
                                  (widget.visitor?.mobileNo?.length ?? 0) - 2,
                                  "******") ??
                              'Not Available'
                          : widget.visitor?.visitorType == 2 &&
                                  !(widget.visitor?.mobileNo.isNullOrEmpty() ??
                                      false)
                              ? widget.visitor?.mobileNo?.replaceRange(
                                      2,
                                      (widget.visitor?.mobileNo?.length ?? 0) -
                                          2,
                                      "******") ??
                                  'Not Available'
                              : 'Not Available',
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              SizedBox(
                width: 120.w,
                child: getFeild(
                  label: 'Gender/ Age',
                  value:
                      "${widget.visitor?.gender != null ? widget.visitor?.gender?.getGender() : ''}${widget.visitor?.age == null || widget.visitor?.gender == null || widget.visitor?.age == 0 && widget.visitor?.gender == 0 ? "" : ","} "
                      "${widget.visitor?.age?.toString() ?? ""}",
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              if (widget.visitor?.visitorType == 2)
                Expanded(
                  child: getFeild(
                    label: 'Visa Number',
                    value: widget.visitor?.visaNumber.isNullOrEmpty() ?? false
                        ? 'N/A'
                        : maskedVisaNumber.isNotEmpty
                            ? "*$maskedVisaNumber"
                            : 'N/A',
                  ),
                ),
              if (widget.visitor?.visitorType == 1)
                Expanded(
                  child: getFeild(
                    label: 'Aadhaar Number',
                    value: widget.visitor?.aadharNo.isNullOrEmpty() ?? false
                        ? 'N/A'
                        : widget.visitor?.aadharNo?.replaceRange(0, 9, "*") ??
                            'N/A',
                  ),
                ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: getFeild(
                  label: 'Blood Group',
                  value: widget.visitor?.bloodGrp == "" ||
                          widget.visitor?.bloodGrp == null
                      ? 'N/A'
                      : widget.visitor?.bloodGrp,
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                flex: 2,
                child: getFeild(
                  label: 'Email',
                  value: widget.visitor?.email.isNullOrEmpty() ?? false
                      ? 'N/A'
                      : widget.visitor?.email ?? 'N/A',
                ),
              ),
            ],
          ),
          if (widget.visitor?.visitorType == 2)
            const SizedBox(
              height: 15,
            ),
          if (widget.visitor?.visitorType == 2)
            Row(
              children: [
                Expanded(
                  child: getFeild(
                    label: 'Country',
                    value: widget.visitor?.country,
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: getFeild(
                    label: 'Passport Number',
                    value: widget.visitor?.passportNo.isNullOrEmpty() ?? false
                        ? 'N/A'
                        : maskedPassportNumber.isNotEmpty
                            ? "*$maskedPassportNumber"
                            : 'N/A',
                  ),
                ),
              ],
            ),
          if (widget.visitor?.visitorType == 1)
            const SizedBox(
              height: 15,
            ),
          if (widget.visitor?.visitorType == 1)
            getFeild(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const FormFieldLabel(
                    label: 'Address',
                  ),
                  const SizedBox(height: 4),
                  Container(
                    decoration: BoxDecoration(
                      color: textFeildFillColor,
                      border: Border.all(
                          color: Colors.grey.withOpacity(0.3), width: 0.5),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: appSize(context: context, unit: 10) / 25,
                          horizontal: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Area : '),
                              Flexible(
                                child: Text(
                                  capitalizedString(
                                      widget.visitor?.area ?? 'N/A'),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              const Text('City : '),
                              Text(
                                capitalizedString(
                                    widget.visitor?.city ?? 'N/A'),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              const Text('Pincode : '),
                              Text(
                                capitalizedString(
                                    widget.visitor?.pincode ?? 'N/A'),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              // label: 'Address',
              // value: capitalizedString(widget.visitor?.city ?? 'N/A'),
            ),
          // Row(
          //   children: [
          //     Expanded(
          //       child: getFeild(
          //         label: 'City',
          //         value: capitalizedString(widget.visitor?.city ?? 'N/A'),
          //       ),
          //     ),
          //     const SizedBox(
          //       width: 15,
          //     ),
          //     Expanded(
          //       child: getFeild(
          //         label: 'Area',
          //         value: capitalizedString(widget.visitor?.area ?? 'N/A'),
          //       ),
          //     ),
          //     const SizedBox(
          //       width: 15,
          //     ),
          //     Expanded(
          //       child: getFeild(
          //         label: 'Pin Code',
          //         value: widget.visitor?.pincode ?? 'N/A',
          //       ),
          //     ),
          //   ],
          // ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Expanded(
                child: getFeild(
                  label: 'Reason To Visit',
                  value: widget.visitor?.visitingReasonFk != 5
                      ? capitalizedString(widget.visitor?.reasonValue ?? 'N/A')
                      : capitalizedString(
                          widget.visitor?.visitingReason ?? 'N/A',
                        ),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              // Expanded(
              //   child: getFeild(
              //     label: 'Criminal Record',
              //     value: widget.visitor?.criminalRecord == "" ||
              //             widget.visitor?.criminalRecord == null
              //         ? 'N/A'
              //         : widget.visitor?.criminalRecord,
              //   ),
              // ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Expanded(
                child: getFeild(
                  label: 'Visiting Till',
                  value: timeStampToDateAndTime2(widget.visitor?.visitingTill),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: getFeild(
                    label: widget.businessType ?? 'Room No',
                    value: widget.visitor?.roomNo ?? ''),
              ),
            ],
          ),

          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Expanded(
                child: getFeild(
                  label:
                      widget.businessType == null ? 'Check In At' : 'Rented On',
                  value: timeStampToDateAndTime2(widget.visitor?.entryDate),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: getFeild(
                  maxlines: 2,
                  label: 'Registration Date',
                  value: widget.visitor?.registrationDate,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Expanded(
                child: getFeild(
                  label: 'Last Updated By',
                  value:
                      capitalizedString(widget.visitor?.lastUpdatedBy ?? 'N/A'),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: getFeild(
                  label: 'Last Updated At',
                  value: timeStampToDateAndTime2(widget.visitor?.updatedAt),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          if ((widget.isFromCurrentVisitors ?? false) ||
              widget.businessType != null)
            UpdateVoterDetails(
              visitor: widget.visitor ?? const Visitor(),
              businessType: widget.businessType == null ? 1 : 2,
            ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
    // return Column(
    //   crossAxisAlignment: CrossAxisAlignment.start,
    //   children: [
    //
    //     const SizedBox(
    //       height: 10,
    //     ),
    //
    //         const Spacer(),
    //         CallingWidget(
    //             visitorId: widget.visitor?.visitorFk ?? 0,
    //             settingId: context
    //                     .read<VirtualNumbersBloc>()
    //                     .state
    //                     .getData()
    //                     ?.records
    //                     ?.first
    //                     .settingId ??
    //                 0),
    //       ],
    //     ),
    //     const Divider(),
    //     const SizedBox(
    //       height: 10,
    //     ),
    //     if (isIndian(widget.visitor?.visitorType))
    //       const Text(
    //         'Aadhar No',
    //         style: text_style_para1,
    //       ),
    //     if (!(isIndian(widget.visitor?.visitorType)))
    //       const Text(
    //         'Passport No',
    //         style: text_style_para1,
    //       ),
    //     const SizedBox(
    //       height: 5,
    //     ),
    //     if (isIndian(widget.visitor?.visitorType))
    //       Row(
    //         children: [
    //           Text(
    //             widget.visitor?.aadharNo.isNullOrEmpty() ?? false
    //                 ? 'Not Available'
    //                 : widget.visitor?.aadharNo
    //                         ?.replaceRange(2, 10, '********') ??
    //                     'Not Available',
    //             style: text_style_title11.copyWith(color: text_color),
    //           ),
    //           const Spacer(),
    //           Visibility(
    //             visible: widget.visitor?.aadharVerifiedStatus == 1,
    //             child: Row(
    //               children: [
    //                 const Icon(
    //                   Icons.check_circle,
    //                   color: Colors.green,
    //                   size: 15,
    //                 ),
    //                 const SizedBox(width: 4),
    //                 Text(
    //                   'Verified',
    //                   style: text_style_title5.copyWith(
    //                     color: Colors.green,
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           )
    //         ],
    //       ),
    //     if (!(isIndian(widget.visitor?.visitorType)))
    //       Row(
    //         children: [
    //           Text(
    //             widget.visitor?.passportNo.isNullOrEmpty() ?? false
    //                 ? 'Not Available'
    //                 : widget.visitor?.passportNo?.replaceRange(
    //                         1,
    //                         ((widget.visitor?.passportNo?.length ?? 0) - 2),
    //                         '********') ??
    //                     'Not Available',
    //             style: text_style_title11.copyWith(color: text_color),
    //           ),
    //           const Spacer(),
    //           Visibility(
    //             visible: widget.visitor?.passportVerifiedStatus == 1,
    //             child: Row(
    //               children: [
    //                 const Icon(
    //                   Icons.check_circle,
    //                   color: Colors.green,
    //                   size: 15,
    //                 ),
    //                 const SizedBox(width: 4),
    //                 Text(
    //                   'Verified',
    //                   style: text_style_title5.copyWith(
    //                     color: Colors.green,
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           )
    //         ],
    //       ),
    //     const Divider(),
    //     const SizedBox(
    //       height: 10,
    //     ),
    //     const Text(
    //       'Email',
    //       style: text_style_para1,
    //     ),
    //     const SizedBox(
    //       height: 5,
    //     ),
    //     if (!(widget.visitor?.email?.isNullOrEmpty() ?? false))
    //       Text(
    //         widget.visitor?.email?.replaceRange(
    //                 1, widget.visitor?.email?.indexOf('@'), "*****") ??
    //             'Not Available',
    //         style: text_style_title11.copyWith(color: text_color),
    //       ),
    //     if (widget.visitor?.email?.isEmpty ?? false)
    //       Text(
    //         'Not Available',
    //         style: text_style_title11.copyWith(
    //           color: text_color,
    //         ),
    //       ),
    //     const Divider(),
    //     const SizedBox(
    //       height: 10,
    //     ),
    //     const Text(
    //       'Room No',
    //       style: text_style_para1,
    //     ),
    //     const SizedBox(
    //       height: 5,
    //     ),
    //     if (!(widget.visitor?.roomNo?.isNullOrEmpty() ?? false))
    //       Text(
    //         widget.visitor?.roomNo ?? 'Not Available',
    //         style: text_style_title11.copyWith(color: text_color),
    //       ),
    //     if (widget.visitor?.roomNo?.isEmpty ?? false)
    //       Text(
    //         'Not Available',
    //         style: text_style_title11.copyWith(
    //           color: text_color,
    //         ),
    //       ),
    //     const Divider(),
    //     const SizedBox(
    //       height: 10,
    //     ),
    //     const Text(
    //       'Visitor is From',
    //       style: text_style_para1,
    //     ),
    //     const SizedBox(
    //       height: 5,
    //     ),
    //     Text(
    //       widget.visitor?.address ?? 'Not Available'.trimRight(),
    //       style: text_style_title11.copyWith(color: text_color),
    //     ),
    //     const Divider(),
    //     const SizedBox(
    //       height: 10,
    //     ),
    //     const Text(
    //       'Reason To Visit',
    //       style: text_style_para1,
    //     ),
    //     const SizedBox(
    //       height: 5,
    //     ),
    //     Text(
    //       widget.visitor?.visitingReasonFk == 3
    //           ? widget.visitor?.visitingReason.isNullOrEmpty() ?? false
    //               ? 'not'
    //               : capitalizedString(widget.visitor?.reasonValue ?? 'not')
    //           : widget.visitor?.reasonValue.isNullOrEmpty() ?? false
    //               ? 'Not Available'
    //               : capitalizedString(
    //                   widget.visitor?.reasonValue ?? 'Not Available',
    //                 ),
    //       style: text_style_title11,
    //     ),
    //     const Divider(),
    //     const SizedBox(
    //       height: 10,
    //     ),
    //     const Text(
    //       'Registration Date',
    //       style: text_style_para1,
    //     ),
    //     const SizedBox(
    //       height: 5,
    //     ),
    //     Text(
    //       // timeStampToDateTime(
    //       widget.visitor?.registrationDate ?? 'Not Available',
    //       // ),
    //       style: text_style_title11.copyWith(color: text_color),
    //     ),
    //     widget.isReported == true
    //         ? const SizedBox.shrink()
    //         : const SizedBox(
    //             height: 10,
    //           ),
    //     const Divider(),
    //     const SizedBox(
    //       height: 10,
    //     ),
    //     const Text(
    //       'Exit Date',
    //       style: text_style_para1,
    //     ),
    //     const SizedBox(
    //       height: 5,
    //     ),
    //     Text(
    //       // timeStampToDateTime(
    //       widget.visitor?.visitingTill ?? 'Not Available',
    //       // ),
    //       style: text_style_title11.copyWith(color: text_color),
    //     ),
    //     widget.isReported == true ? const SizedBox.shrink() : const Divider(),
    //     widget.isReported == true
    //         ? const SizedBox.shrink()
    //         : const SizedBox(
    //             height: 10,
    //           ),
    //     widget.isReported == true
    //         ? Container()
    //         : Text(
    //             visitingFrom(userDetails?.branchCategory).toString(),
    //             style: text_style_para1,
    //           ),
    //     widget.isReported == true
    //         ? Container()
    //         : const SizedBox(
    //             height: 5,
    //           ),
    //     widget.isReported == true
    //         ? Container()
    //         : Text(
    //             // timeStampToDateTime(
    //             widget.visitor?.entryDate ?? 'Not Available',
    //             // ),
    //             style: text_style_title11),
    //     widget.isReported == true ? const SizedBox.shrink() : const Divider(),
    //     widget.isReported == true
    //         ? const SizedBox.shrink()
    //         : const SizedBox(
    //             height: 10,
    //           ),
    //     widget.isReported == true
    //         ? Container()
    //         : Text(
    //             visitingTill(userDetails?.branchCategory).toString(),
    //             style: text_style_para1,
    //           ),
    //     widget.isReported == true
    //         ? Container()
    //         : const SizedBox(
    //             height: 5,
    //           ),
    //     widget.isReported == true
    //         ? Container()
    //         : Text(
    //             timeStampToDateTime(widget.visitor?.visitorExitDate),
    //             style: text_style_title11,
    //           ),
    //     const Divider(),
    //     const SizedBox(
    //       height: 10,
    //     ),
    //     const Text(
    //       'QR Expire',
    //       style: text_style_para1,
    //     ),
    //     const SizedBox(
    //       height: 5,
    //     ),
    //     Text(
    //       'Tentative: ${timeStampToDateTime(widget.visitor?.expiryDate)}',
    //       style: text_style_title11,
    //     ),
    //     const Divider(),
    //     const SizedBox(
    //       height: 20,
    //     ),
    //     Text(
    //       'Last Update date : ${timeStampToDateTime(widget.visitor?.updatedAt)}',
    //       style: text_style_para1,
    //     ),
    //     const Divider(),
    //     const SizedBox(
    //       height: 20,
    //     ),
    //     Text(
    //       'Last Updated by : ${widget.visitor?.lastUpdatedBy ?? 'Not Available'}',
    //       style: text_style_para1,
    //     ),
    //     const Divider(),
    //     const SizedBox(
    //       height: 10,
    //     ),
    //     if ((getLocationStatus(
    //               currentLatitude: currentPosition?.latitude,
    //               currentLongitude: currentPosition?.longitude,
    //             ) ??
    //             false) &&
    //         (widget.isFromCurrentVisitors ?? false))
    //       UpdateVoterDetails(
    //         visitor: widget.visitor ?? const Visitor(),
    //       ),
    //     const SizedBox(
    //       height: 20,
    //     ),
    //   ],
    // );
  }
}
