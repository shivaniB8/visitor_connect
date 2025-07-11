import 'dart:io';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:host_visitor_connect/common/custom_widget/app_bar_widget/custom_widget_image_app_bar.dart';
import 'package:host_visitor_connect/common/custom_widget/button.dart';
import 'package:host_visitor_connect/common/custom_widget/fields/form_field_label.dart';
import 'package:host_visitor_connect/common/custom_widget/widget/calling.dart';
import 'package:host_visitor_connect/common/custom_widget/widget/qrCode_dialog.dart';
import 'package:host_visitor_connect/common/extensions/number_extensions.dart';
import 'package:host_visitor_connect/common/extensions/string_extensions.dart';
import 'package:host_visitor_connect/common/res/colors.dart';
import 'package:host_visitor_connect/common/res/keys.dart';
import 'package:host_visitor_connect/common/res/paths.dart';
import 'package:host_visitor_connect/common/res/styles.dart';
import 'package:host_visitor_connect/common/upload_image.dart';
import 'package:host_visitor_connect/common/utils/route_generator.dart';
import 'package:host_visitor_connect/features/qr/bloc/face_match_bloc.dart';
import 'package:host_visitor_connect/features/qr/data/network/responses/qr_scanner_data_response.dart';
import 'package:host_visitor_connect/features/qr/ui/qr_code_scanner.dart';
import 'package:host_visitor_connect/features/rentals/data/network/responses/driving_licence_data.dart';
import 'package:host_visitor_connect/features/visitors/add_visitor/bloc/blood_grp_bloc.dart';
import 'package:host_visitor_connect/features/visitors/add_visitor/ui/second_form_provider.dart';
import 'package:host_visitor_connect/features/visitors/add_visitor/ui1/add_visitor_second_screen.dart';
import 'package:host_visitor_connect/features/visitors/visitor_listing/blocs/virtual_numbers_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class QrScannedVisitor extends StatefulWidget {
  final QrScannerDataResponse? visitor;
  final DrivingLicenseData? licenceData;
  final bool? isForeigner;
  final bool? isIndian;
  final bool? visitorAlreadyExists;
  final int? businessType;

  const QrScannedVisitor({
    super.key,
    this.visitor,
    this.licenceData,
    this.isForeigner,
    this.isIndian,
    this.visitorAlreadyExists,
    this.businessType,
  });

  @override
  State<QrScannedVisitor> createState() => _QrScannedVisitorState();
}

class _QrScannedVisitorState extends State<QrScannedVisitor> {
  bool? _isChecked;
  int? _selectedValue;
  XFile? campaignPhoto;

  @override
  void initState() {
    context.read<BloodGrpBloc>().getBloodGrps();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String visaNumber = widget.visitor?.visaNumber ?? '';
    String maskedVisaNumber = visaNumber.length >= 3
        ? visaNumber.substring(visaNumber.length - 3)
        : '';
    String passportNumber = widget.visitor?.passportNo ?? '';
    String maskedPassportNumber = passportNumber.length >= 3
        ? passportNumber.substring(passportNumber.length - 3)
        : '';
    final settingId = context
                .read<VirtualNumbersBloc>()
                .state
                .getData()
                ?.records
                ?.isNotEmpty ==
            true
        ? context
                .read<VirtualNumbersBloc>()
                .state
                .getData()
                ?.records
                ?.first
                .settingId ??
            0
        : 0;
    print('addresss ${widget.visitor?.address}');
    print('addresss ${widget.visitor?.address?.length}');
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomImageAppBar(
        title: 'Visitor Details',
        context: context,
        showSettings: false,
        showEditIcon: false,
        actionButton: [
          // IconButton(
          //   onPressed: () {
          //     Navigator.push(
          //       context,
          //       goToRoute(
          //         SecondFormProvider(
          //           child: AddVisitorSecondScreen(
          //             isFromScan: true,
          //             visitorType: widget.visitor?.visitorType ?? 0,
          //             qrScannerDataResponse: widget.visitor,
          //             businessType: widget.businessType,
          //             // isScanner: true,
          //           ),
          //         ),
          //       ),
          //     );
          //   },
          //   icon: Row(
          //     children: [
          //       Text(
          //         'Next',
          //         style: AppStyle.titleLarge(context)
          //             .copyWith(color: primary_text_color),
          //       ),
          //       SizedBox(
          //         width: 5.w,
          //       ),
          //       const Icon(
          //         Icons.arrow_forward,
          //         color: Colors.white,
          //       ),
          //     ],
          //   ),
          // )
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          color: Color(0xFFFFFFFF),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 0, right: 0, bottom: 0),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (widget.licenceData?.id != null)
                          Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: const BoxDecoration(
                              color: Color(0xFFFFFFFF),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 1,
                                      color: Colors.grey.withOpacity(0.2),
                                    ),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0, vertical: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              child: (!(widget
                                                          .licenceData?.photo
                                                          .isNullOrEmpty() ??
                                                      false))
                                                  ? Image.network(
                                                      '$googlePhotoUrl${getBucketName()}$drivingLicencePhoto${widget.licenceData?.photo}'
                                                      '',
                                                      fit: BoxFit.cover,
                                                      height: appSize(
                                                              context: context,
                                                              unit: 10) /
                                                          2.5,
                                                      width: appSize(
                                                              context: context,
                                                              unit: 10) /
                                                          2.5,
                                                    )
                                                  : Image.asset(
                                                      '$icons_path/avatar.png',
                                                      fit: BoxFit.cover,
                                                      height: appSize(
                                                              context: context,
                                                              unit: 10) /
                                                          2.5,
                                                      width: appSize(
                                                              context: context,
                                                              unit: 10) /
                                                          2.5,
                                                    ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          capitalizedString(widget.licenceData
                                                  ?.nameOnDrivingLicense ??
                                              'Not Available'),
                                          style: AppStyle.bodyMedium(context)
                                              .copyWith(
                                                  fontWeight: FontWeight.w500),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          widget.licenceData
                                                  ?.drivingLicenseNo ??
                                              'Not Available',
                                          style: AppStyle.bodyMedium(context)
                                              .copyWith(
                                                  fontWeight: FontWeight.w500),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          widget.licenceData?.rtoName ??
                                              'Not Available',
                                          style: AppStyle.bodyMedium(context)
                                              .copyWith(
                                                  fontWeight: FontWeight.w500),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                  text: 'Address',
                                                  style: AppStyle.bodyMedium(
                                                      context)),
                                              TextSpan(
                                                  text: ' : ',
                                                  style: AppStyle.bodyMedium(
                                                      context)),
                                              TextSpan(
                                                text: widget.licenceData
                                                        ?.permanentAdd ??
                                                    'Not Available',
                                                style: AppStyle.bodyMedium(
                                                    context),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                  text: 'Current Address',
                                                  style: AppStyle.bodyMedium(
                                                      context)),
                                              TextSpan(
                                                  text: ' : ',
                                                  style: AppStyle.bodyMedium(
                                                      context)),
                                              TextSpan(
                                                text: widget.licenceData
                                                        ?.currentAdd ??
                                                    'Not Available',
                                                style: AppStyle.bodyMedium(
                                                    context),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: 'Gender: ',
                                                style: AppStyle.bodyMedium(
                                                    context),
                                              ),
                                              TextSpan(
                                                text: widget.licenceData?.gender
                                                    ?.getGender(),
                                                style: AppStyle.bodyMedium(
                                                    context),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                  text: 'Date of Birth: ',
                                                  style: AppStyle.bodyMedium(
                                                      context)),
                                              TextSpan(
                                                text: widget.licenceData?.dob ??
                                                    'Not Available',
                                                style:
                                                    AppStyle.bodyMedium(context)
                                                        .copyWith(
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        const SizedBox(
                          height: 0,
                        ),
                        Row(
                          children: [
                            if ((widget.visitor?.aadharImage.isNullOrEmpty() ??
                                    false) &&
                                (widget.visitor?.image.isNullOrEmpty() ??
                                    false))
                              Container(
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: background_dark_grey),
                                height:
                                    appSize(context: context, unit: 10) / 2.5,
                                width:
                                    appSize(context: context, unit: 10) / 2.5,
                                child: ClipOval(
                                  child: Image.asset(
                                    '$icons_path/avatar.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            if (!(widget.visitor?.aadharImage.isNullOrEmpty() ??
                                    false) ||
                                !(widget.visitor?.image.isNullOrEmpty() ??
                                    false))
                              CachedNetworkImage(
                                imageUrl: !(widget.visitor?.image
                                            .isNullOrEmpty() ??
                                        false)
                                    ? '$googlePhotoUrl${getBucketName()}$voterPhotoFolder${widget.visitor?.image}'
                                    : '$googlePhotoUrl${getBucketName()}$visitorAadharFolder${widget.visitor?.aadharImage}',
                                cacheKey: !(widget.visitor?.image
                                            .isNullOrEmpty() ??
                                        false)
                                    ? '$googlePhotoUrl${getBucketName()}$voterPhotoFolder${widget.visitor?.image}'
                                    : '$googlePhotoUrl${getBucketName()}$visitorAadharFolder${widget.visitor?.aadharImage}',
                                imageBuilder: (context, imageProvider) {
                                  return Container(
                                    width: appSize(context: context, unit: 10) /
                                        2.5,
                                    height:
                                        appSize(context: context, unit: 10) /
                                            2.5,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  );
                                },
                                placeholder: (context, url) => Container(
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: background_dark_grey,
                                    ),
                                    padding: EdgeInsets.all(
                                        appSize(context: context, unit: 10) /
                                            10),
                                    child: const CircularProgressIndicator()),
                                errorWidget: (context, url, error) =>
                                    CircleAvatar(
                                  radius: 50,
                                  backgroundColor: background_dark_grey,
                                  child: Image.asset(
                                    fit: BoxFit.contain,
                                    '$icons_path/gallery.png',
                                    width: appSize(context: context, unit: 10) /
                                        6.0,
                                    height:
                                        appSize(context: context, unit: 10) /
                                            6.0,
                                  ),
                                ),
                              ),
                            const Spacer(),
                            if (!(widget.visitor?.qrImage.isNullOrEmpty() ??
                                false))
                              GestureDetector(
                                onTap: () {
                                  QRCodeDialog.showQRCodeDialog(
                                      context: context,
                                      qrImage: widget.visitor?.qrImage);
                                },
                                child: Column(
                                  children: [
                                    Container(
                                      width:
                                          appSize(context: context, unit: 10) /
                                              2.5,
                                      height:
                                          appSize(context: context, unit: 10) /
                                              2.5,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: const DecorationImage(
                                          image: ExactAssetImage(
                                              '$images_path/qr-code.png'),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      child: ClipRRect(
                                        // Clip it cleanly.
                                        child: BackdropFilter(
                                          filter: ImageFilter.blur(
                                              sigmaX: 2, sigmaY: 2),
                                          child: Container(
                                            color: Colors.grey.withOpacity(0.0),
                                            alignment: Alignment.center,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'Click to check QR',
                                      style: AppStyle.bodyMedium(context),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Name',
                          style: AppStyle.bodyMedium(context),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                capitalizedString(
                                  widget.visitor?.fullName ?? 'Not Available',
                                ),
                                style: AppStyle.bodyMedium(context)
                                    .copyWith(fontWeight: FontWeight.w500),
                              ),
                            ),
                            Text(
                              "${widget.visitor?.age?.toString() ?? ""}${widget.visitor?.age == null && widget.visitor?.gender == null || widget.visitor?.age == 0 && widget.visitor?.gender == 0 ? "" : ","}"
                              " ${widget.visitor?.gender != null ? widget.visitor?.gender == 0 ? "" : widget.visitor?.gender == 1 ? "M" : widget.visitor?.gender == 2 ? "F" : widget.visitor?.gender.toString() ?? "" : ""}",
                              style: AppStyle.bodyMedium(context)
                                  .copyWith(fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        const Divider(),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Mobile No',
                          style: AppStyle.bodyMedium(context),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Text(
                              widget.visitor?.mobileNo.isNullOrEmpty() ?? false
                                  ? "Not Available"
                                  : widget.visitor?.mobileNo?.replaceRange(
                                          2,
                                          (widget.visitor?.mobileNo?.length ??
                                                  0) -
                                              2,
                                          "******") ??
                                      'Not Available',
                              style: AppStyle.bodyMedium(context)
                                  .copyWith(fontWeight: FontWeight.w500),
                            ),
                            const Spacer(),
                            settingId != 0
                                ? CallingWidget(
                                    visitorId: widget.visitor?.id ?? 0,
                                    settingId: settingId)
                                : const SizedBox.shrink(),
                          ],
                        ),
                        const Divider(),
                        const SizedBox(
                          height: 10,
                        ),
                        if ((widget.visitor?.visitorType == 1))
                          Text(
                            'Aadhaar No',
                            style: AppStyle.bodyMedium(context),
                          ),
                        if ((widget.visitor?.visitorType == 2))
                          Text(
                            'Passport No',
                            style: AppStyle.bodyMedium(context),
                          ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            if ((widget.visitor?.visitorType == 2))
                              Text(
                                widget.visitor?.passportNo.isNullOrEmpty() ??
                                        false
                                    ? 'N/A'
                                    : maskedPassportNumber.isNotEmpty
                                        ? "*$maskedPassportNumber"
                                        : 'N/A',
                                style: AppStyle.bodyMedium(context)
                                    .copyWith(fontWeight: FontWeight.w500),
                              ),
                            if ((widget.visitor?.visitorType == 1))
                              Text(
                                widget.visitor?.aadharNo.isNullOrEmpty() ??
                                        false
                                    ? "Not Available"
                                    : widget.visitor?.aadharNo
                                            ?.replaceRange(2, 10, "********") ??
                                        "Not Available",
                                style: AppStyle.bodyMedium(context)
                                    .copyWith(fontWeight: FontWeight.w500),
                              ),
                            const Spacer(),
                            if (!(widget.visitor?.aadharNo.isNullOrEmpty() ??
                                false))
                              const Icon(
                                Icons.check_circle,
                                color: Colors.green,
                                size: 15,
                              ),
                            if (!(widget.visitor?.aadharNo.isNullOrEmpty() ??
                                false))
                              const SizedBox(
                                width: 4,
                              ),
                            if (!(widget.visitor?.aadharNo.isNullOrEmpty() ??
                                false))
                              Text(
                                'Verified',
                                style: AppStyle.bodyMedium(context).copyWith(
                                    color: Colors.green,
                                    fontWeight: FontWeight.w500),
                              )
                          ],
                        ),
                        const Divider(),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Email',
                          style: AppStyle.bodyMedium(context),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        if (!(widget.visitor?.email?.isNullOrEmpty() ?? false))
                          Text(
                            widget.visitor?.email?.replaceRange(
                                    1,
                                    widget.visitor?.email?.indexOf('@'),
                                    "*****") ??
                                'Not Available',
                            style: AppStyle.bodyMedium(context)
                                .copyWith(fontWeight: FontWeight.w500),
                          ),
                        if (widget.visitor?.email?.isEmpty ?? false)
                          Text(
                            'Not Available',
                            style: AppStyle.bodyMedium(context)
                                .copyWith(fontWeight: FontWeight.w500),
                          ),
                        const Divider(),
                        const SizedBox(
                          height: 10,
                        ),

                        Text(
                          'Visitor Address',
                          style: AppStyle.bodyMedium(context),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          widget.visitor?.address == null ||
                                  widget.visitor?.address == ''
                              ? 'Not Available'
                              : '${widget.visitor?.address?.trimLeft().trimRight().replaceRange((widget.visitor?.address?.trimLeft().trimRight()?.length ?? 0) > 3 ? 3 : 0, widget.visitor?.address?.trimLeft().trimRight()?.length, '**************')} ${widget.visitor?.city ?? ''} ${widget.visitor?.state ?? ''} ${widget.visitor?.pincode ?? ''}' ??
                                  '',
                          style: AppStyle.bodyMedium(context)
                              .copyWith(fontWeight: FontWeight.w500),
                        ),
                        const Divider(),
                        const SizedBox(
                          height: 25,
                        ),
                        FormFieldLabel(
                          isFromFilter: true,
                          label: 'Profile Match',
                          style: AppStyle.titleSmall(context),
                          isRequired: true,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Colors.grey.withOpacity(0.3),
                                ),
                              ),
                              child: Row(
                                children: <Widget>[
                                  Radio(
                                    activeColor: primary_color,
                                    value: 1,
                                    groupValue: _selectedValue,
                                    onChanged: (int? value) {
                                      setState(() {
                                        _selectedValue = value!;
                                      });
                                    },
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 15.0),
                                    child: Text(
                                      'Yes',
                                      style: AppStyle.bodyMedium(context),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Colors.grey.withOpacity(0.3),
                                ),
                              ),
                              child: Row(
                                children: <Widget>[
                                  Radio(
                                    activeColor: primary_color,
                                    value: 2,
                                    groupValue: _selectedValue,
                                    onChanged: (int? value) {
                                      setState(() {
                                        _selectedValue = value!;
                                      });
                                    },
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 15.0),
                                    child: Text(
                                      'No',
                                      style: AppStyle.bodyMedium(context),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),

                        Row(
                          children: [
                            if (_selectedValue == 2)
                              Row(
                                children: [
                                  UploadImage(
                                    isEnable: true,
                                    onImageSelected: (image) {
                                      setState(() async {
                                        // Navigator.pop(context);
                                        campaignPhoto = image;
                                        Navigator.pop(context);

                                        await context
                                            .read<FaceMatchBloc>()
                                            .faceMatch(
                                              aadhaarPhoto: widget.visitor
                                                      ?.aadharPhotoUrl ??
                                                  '',
                                              visitorId:
                                                  widget.visitor?.id ?? 0,
                                              profilePhoto:
                                                  campaignPhoto ?? XFile(''),
                                            );
                                        // Navigator.pop(context);
                                      });
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 5),
                                      decoration: BoxDecoration(
                                        // color: AppColors.darkBlueColor,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Row(
                                        children: [
                                          Text(
                                            'Add Photo',
                                            style: AppStyle.titleLarge(context)
                                                .copyWith(
                                              color: Colors.black,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          const Icon(
                                            Icons.upload,
                                            color: Colors.black,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  if (!(campaignPhoto?.path.isNullOrEmpty() ??
                                      true))
                                    const SizedBox(
                                      width: 5,
                                    ),
                                  if (!(campaignPhoto?.path.isNullOrEmpty() ??
                                      true))
                                    Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Image.file(
                                        File(campaignPhoto?.path ?? ''),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                ],
                              ),
                          ],
                        ),

                        SizedBox(
                          height: _selectedValue == 1 ? 5 : 20,
                        ),
                        if (context.watch<FaceMatchBloc>().state.isSuccess())
                          Text(
                            '${context.read<FaceMatchBloc>().state.getData()?.message}',
                            style: AppStyle.titleLarge(context)
                                .copyWith(color: Colors.green),
                          ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Divider(),
                        if (context.watch<FaceMatchBloc>().state.isLoading())
                          LinearProgressIndicator(
                            backgroundColor: Colors.green.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10),
                            minHeight: 20,
                            valueColor: const AlwaysStoppedAnimation<Color>(
                                Colors.green),
                          ),
                        const SizedBox(
                          height: 20,
                        ),
                        // const Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Checkbox(
                              activeColor: toast_valid_stroke_color,
                              value: _isChecked ?? false,
                              onChanged: (bool? newValue) {
                                print(newValue);
                                setState(() {
                                  _isChecked =
                                      newValue ?? false; // Update the state
                                });
                              },
                            ),
                            Flexible(
                              child: Text(
                                'Confirming Persons Physical Identity, Person Checking in is matching with the above photo.',
                                style: AppStyle.bodyMedium(context)
                                    .copyWith(fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                        if (_isChecked == false &&
                            context.watch<FaceMatchBloc>().state.isLoading())
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              'Kindly confirm persons identity ',
                              style: AppStyle.errorStyle(context),
                            ),
                          ),

                        const SizedBox(
                          height: 10,
                        ),
                        if (_selectedValue == 1 ||
                            context.read<FaceMatchBloc>().state.isSuccess())
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Button(
                              isRectangularBorder: true,
                              text: 'Scan Another Visitor',
                              onPressed: () {
                                if (_isChecked == true && _selectedValue == 1) {
                                  Navigator.push(
                                    context,
                                    goToRoute(
                                      QRCodeScanner(
                                        businessType: widget.businessType ?? 0,
                                      ),
                                    ),
                                  );
                                } else {
                                  setState(() {
                                    print('hello');
                                    _isChecked = false;
                                  });
                                }
                              },
                            ),
                          ),
                        const SizedBox(
                          height: 10,
                        ),
                        if (_selectedValue == 1 ||
                            context.watch<FaceMatchBloc>().state.isSuccess())
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Button(
                              isRectangularBorder: true,
                              text: 'Check In',
                              onPressed: () {
                                if (_isChecked == true) {
                                  Navigator.push(
                                    context,
                                    goToRoute(
                                      SecondFormProvider(
                                        child: AddVisitorSecondScreen(
                                          isFromScan: true,
                                          visitorType:
                                              widget.visitor?.visitorType ?? 0,
                                          qrScannerDataResponse: widget.visitor,
                                          businessType: widget.businessType,
                                          // isScanner: true,
                                        ),
                                      ),
                                    ),
                                  );
                                } else {
                                  setState(() {
                                    _isChecked = false;
                                  });
                                }
                              },
                            ),
                          )
                        // UpdateVoterDetails(
                        //   isFromScan: true,
                        //   visitor: Visitor(
                        //       id: widget.visitor?.historyId,
                        //       visitorFk: widget.visitor?.id,
                        //       fullName: widget.visitor?.fullName,
                        //       address: widget.visitor?.address,
                        //       registrationDate:
                        //           widget.visitor?.registrationDate,
                        //       image: widget.visitor?.image,
                        //       email: widget.visitor?.email,
                        //       expiryDate: widget.visitor?.expiryDate,
                        //       entryDate: widget.visitor?.entryDate,
                        //       aadharImage: widget.visitor?.aadharImage,
                        //       visitingReason: widget.visitor?.visitingReason,
                        //       mobileNo: widget.visitor?.mobileNo,
                        //       aadharNo: widget.visitor?.aadharNo,
                        //       age: widget.visitor?.age,
                        //       country: widget.visitor?.country,
                        //       gender: widget.visitor?.gender,
                        //       passportNo: widget.visitor?.passportNo,
                        //       qrImage: widget.visitor?.qrImage,
                        //       visitorExitDate: widget.visitor?.visaExpiryDate,
                        //       visaNumber: widget.visitor?.visaNumber,
                        //       bloodGrp: widget.visitor?.bloodGrp,
                        //       bloodGrpFk: widget.visitor?.bloodGrpFk,
                        //       reasonValue: widget.visitor?.reasonValue,
                        //       visitingReasonFk:
                        //           widget.visitor?.visitingReasonFk,
                        //       roomNo: widget.visitor?.roomNo,
                        //       visaExpiryDate: widget.visitor?.visaExpiryDate,
                        //       visitorType: widget.visitor?.visitorType,
                        //       title: widget.visitor?.title,
                        //       fkTitle: widget.visitor?.fkTitle,
                        //       firstName: widget.visitor?.firstName,
                        //       middleName: widget.visitor?.middleName,
                        //       lastName: widget.visitor?.lastName,
                        //       visaPhoto: widget.visitor?.visaPhoto,
                        //       passportFrontPhoto:
                        //           widget.visitor?.passportFrontPhoto,
                        //       birthDate: widget.visitor?.dateOfBirth,
                        //       businessType: widget.visitor?.businessType,
                        //       passportBackPhoto:
                        //           widget.visitor?.passportBackPhoto),
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
