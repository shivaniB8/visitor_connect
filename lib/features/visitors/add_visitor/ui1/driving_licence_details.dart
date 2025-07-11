import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:host_visitor_connect/common/custom_widget/app_bar_widget/title_bar.dart';
import 'package:host_visitor_connect/common/custom_widget/button.dart';
import 'package:host_visitor_connect/common/custom_widget/success_screen.dart';
import 'package:host_visitor_connect/common/extensions/string_extensions.dart';
import 'package:host_visitor_connect/common/res/keys.dart';
import 'package:host_visitor_connect/common/res/paths.dart';
import 'package:host_visitor_connect/common/res/styles.dart';
import 'package:host_visitor_connect/common/utils/route_generator.dart';
import 'package:host_visitor_connect/features/rentals/data/network/responses/driving_licence_data.dart';

class DrivingLicenceDetails extends StatefulWidget {
  final DrivingLicenseData? licenceData;
  final bool? isForeigner;
  final bool? isIndian;
  final bool? isOldVisitor;
  final String? licenceNo;
  final String? dob;
  final int? id;
  final String? name;

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
  });

  @override
  State<DrivingLicenceDetails> createState() => _DrivingLicenceDetailsState();
}

class _DrivingLicenceDetailsState extends State<DrivingLicenceDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Stack(
          children: [
            const TitleBar(
              title: 'Visitor Details',
              isBack: false,
            ),
            Positioned(
              top: 180,
              left: 0.1,
              right: 0.1,
              bottom: 0,
              child: Container(
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              width: 1,
                                              color:
                                                  Colors.grey.withOpacity(0.2),
                                            ),
                                            borderRadius:
                                                const BorderRadius.all(
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
                                                          BorderRadius.circular(
                                                              5),
                                                      child: (!(widget
                                                                  .licenceData
                                                                  ?.photo
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
                                                  capitalizedString(widget
                                                          .licenceData
                                                          ?.nameOnDrivingLicense ??
                                                      'Not Available'),
                                                  style: text_style_title13
                                                      .copyWith(
                                                          color: Colors.black),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  widget.licenceData
                                                          ?.drivingLicenseNo ??
                                                      'Not Available',
                                                  style: text_style_title13
                                                      .copyWith(
                                                          color: Colors.black),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  widget.licenceData?.rtoName ??
                                                      'Not Available',
                                                  style: text_style_title13
                                                      .copyWith(
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
                                                          style:
                                                              text_style_para1),
                                                      const TextSpan(
                                                          text: ' : ',
                                                          style:
                                                              text_style_para1),
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
                                                          text:
                                                              'Current Address',
                                                          style:
                                                              text_style_para1),
                                                      const TextSpan(
                                                          text: ' : ',
                                                          style:
                                                              text_style_para1),
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
                                                  text: const TextSpan(
                                                    children: [
                                                      TextSpan(
                                                        text: 'Gender: ',
                                                        style: text_style_para1,
                                                      ),
                                                      // TextSpan(
                                                      //   text: widget
                                                      //       .licenceData?.gender
                                                      //       ?.getGender(),
                                                      //   style:
                                                      //       text_style_title13,
                                                      // ),
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
                                                          text:
                                                              'Date of Birth: ',
                                                          style:
                                                              text_style_para1),
                                                      TextSpan(
                                                        text: widget.licenceData
                                                                ?.dob ??
                                                            'Not Available',
                                                        style:
                                                            text_style_title13,
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
                                  height: 50,
                                  width: MediaQuery.of(context).size.width,
                                  child: Button(
                                    text: 'Continue',
                                    onPressed: () {
                                      Navigator.of(context).push(
                                        goToRoute(
                                          SuccessScreen(
                                            isVisitor: true,
                                            title: widget.isOldVisitor ?? false
                                                ? 'Visitor Updated Successfully'
                                                : 'Visitor Added Successfully',
                                            subtitle: widget.isOldVisitor ??
                                                    false
                                                ? 'Visitor has been updated successfully'
                                                : 'Visitor has been added successfully',
                                          ),
                                        ),
                                      );
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
