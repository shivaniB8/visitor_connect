import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/common/custom_widget/app_bar_widget/custom_widget_image_app_bar.dart';
import 'package:host_visitor_connect/common/custom_widget/app_success_page.dart';
import 'package:host_visitor_connect/common/custom_widget/button.dart';
import 'package:host_visitor_connect/common/extensions/number_extensions.dart';
import 'package:host_visitor_connect/common/extensions/string_extensions.dart';
import 'package:host_visitor_connect/common/res/keys.dart';
import 'package:host_visitor_connect/common/res/paths.dart';
import 'package:host_visitor_connect/common/res/styles.dart';
import 'package:host_visitor_connect/common/utils/route_generator.dart';
import 'package:host_visitor_connect/features/qr/bloc/qr_scanner_bloc.dart';
import 'package:host_visitor_connect/features/qr/ui/qr_scannerd_visitor.dart';
import 'package:host_visitor_connect/features/rentals/data/network/responses/driving_licence_data.dart';
import 'package:host_visitor_connect/features/visitors/add_visitor/bloc/blood_grp_bloc.dart';
import 'package:host_visitor_connect/features/visitors/visitor_listing/blocs/outgoing_call_bloc.dart';
import 'package:provider/provider.dart';

class DrivingLicenceDetails extends StatefulWidget {
  final DrivingLicenseData? licenceData;
  final bool? isForeigner;
  final bool? isIndian;
  final bool? isOldVisitor;
  final String? licenceNo;
  final String? dob;
  final int? id;
  final String? name;
  final bool? isFromQr;
  final int? businessType;

  const DrivingLicenceDetails({
    super.key,
    // this.visitor,
    this.licenceData,
    this.isForeigner,
    this.isIndian,
    this.isOldVisitor,
    this.licenceNo,
    this.dob,
    this.id,
    this.name,
    this.isFromQr,
    this.businessType,
  });

  @override
  State<DrivingLicenceDetails> createState() => _DrivingLicenceDetailsState();
}

class _DrivingLicenceDetailsState extends State<DrivingLicenceDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomImageAppBar(
        title: 'Driving Licence Details',
        context: context,
        showSettings: false,
        showEditIcon: false,
      ),
      body: Padding(
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
                                            child: (!(widget.licenceData?.photo
                                                        .isNullOrEmpty() ??
                                                    false))
                                                ? Image.network(
                                                    '$googlePhotoUrl${getBucketName()}$drivingLicencePhoto${widget.licenceData?.photo}'
                                                    '',
                                                    fit: BoxFit.cover,
                                                    height: 80,
                                                    width: 80,
                                                  )
                                                : Image.asset(
                                                    '$icons_path/avatar.png',
                                                    fit: BoxFit.cover,
                                                    height: 80,
                                                    width: 80,
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
                                        style: text_style_title13.copyWith(
                                            color: Colors.black),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        widget.licenceData?.drivingLicenseNo ??
                                            'Not Available',
                                        style: text_style_title13.copyWith(
                                            color: Colors.black),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        widget.licenceData?.rtoName ??
                                            'Not Available',
                                        style: text_style_title13.copyWith(
                                            color: Colors.black),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      RichText(
                                        text: TextSpan(
                                          children: [
                                            const TextSpan(
                                                text: 'Address',
                                                style: text_style_para1),
                                            const TextSpan(
                                                text: ' : ',
                                                style: text_style_para1),
                                            TextSpan(
                                              text: widget.licenceData
                                                      ?.permanentAdd ??
                                                  'Not Available',
                                              style: text_style_para1,
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
                                            const TextSpan(
                                                text: 'Current Address',
                                                style: text_style_para1),
                                            const TextSpan(
                                                text: ' : ',
                                                style: text_style_para1),
                                            TextSpan(
                                              text: widget.licenceData
                                                      ?.currentAdd ??
                                                  'Not Available',
                                              style: text_style_para1,
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
                                            const TextSpan(
                                              text: 'Gender: ',
                                              style: text_style_para1,
                                            ),
                                            TextSpan(
                                              text: widget.licenceData?.gender
                                                  ?.getGender(),
                                              style: text_style_title13,
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
                                            const TextSpan(
                                                text: 'Date of Birth: ',
                                                style: text_style_para1),
                                            TextSpan(
                                              text: widget.licenceData?.dob ??
                                                  'Not Available',
                                              style: text_style_title13,
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
                        height: 15,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Button(
                          text: 'Continue',
                          onPressed: () {
                            if (widget.isFromQr ?? false) {
                              Navigator.push(
                                context,
                                goToRoute(
                                  MultiProvider(
                                    providers: [
                                      BlocProvider(
                                        create: (context) => OutgoingCallBloc(),
                                      ),
                                      BlocProvider(
                                        create: (context) => BloodGrpBloc(),
                                      ),
                                    ],
                                    child: QrScannedVisitor(
                                      businessType: widget.businessType,
                                      visitor: context
                                          .read<QrScannerBloc>()
                                          .state
                                          .getData()
                                          ?.data,
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              Navigator.pushReplacement(
                                  context,
                                  goToRoute(SuccessAppScreen(
                                    img: '$icons_path/Group.png',
                                    title: 'Congratulations!',
                                    subtitle: widget.isOldVisitor ?? false
                                        ? 'Visitor has been updated successfully'
                                        : 'Visitor has been added successfully',
                                    showBackButton: false,
                                  )));
                            }
                          },
                          isRectangularBorder: true,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
