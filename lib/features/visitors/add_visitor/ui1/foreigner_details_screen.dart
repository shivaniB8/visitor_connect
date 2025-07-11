import 'package:flutter/material.dart';
import 'package:host_visitor_connect/common/custom_widget/app_bar_widget/title_bar.dart';
import 'package:host_visitor_connect/common/custom_widget/button.dart';
import 'package:host_visitor_connect/common/extensions/string_extensions.dart';
import 'package:host_visitor_connect/common/res/keys.dart';
import 'package:host_visitor_connect/common/res/paths.dart';
import 'package:host_visitor_connect/common/res/styles.dart';
import 'package:host_visitor_connect/common/utils/route_generator.dart';
import 'package:host_visitor_connect/features/visitors/add_visitor/data/network/response/foreigner_data.dart';
import 'package:host_visitor_connect/features/visitors/add_visitor/data/network/response/mobile_response_data.dart';
import 'package:host_visitor_connect/features/visitors/add_visitor/ui1/add_visitor_second_screen.dart';
import 'package:host_visitor_connect/features/visitors/add_visitor/ui1/second_form_provider.dart';

class ForeignerDetailsScreen extends StatefulWidget {
  // final Visitor? visitor;
  final String? mobileNumber;
  final bool? visitorAlreadyExists;
  final ForeignerData? foreignerData;

  final bool? isForeignerUpdate;
  final MobileResponseData? mobileResponseData;

  const ForeignerDetailsScreen({
    super.key,
    this.foreignerData,
    this.visitorAlreadyExists,
    // this.visitor,
    this.mobileNumber,
    this.mobileResponseData,
    this.isForeignerUpdate,
  });

  @override
  State<ForeignerDetailsScreen> createState() => _ForeignerDetailsScreenState();
}

class _ForeignerDetailsScreenState extends State<ForeignerDetailsScreen> {
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
              isBack: false,
              title: 'Foreigner Details',
            ),
            Positioned(
              top: 180,
              left: 0.1,
              right: 0.1,
              bottom: 0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 300,
                decoration: const BoxDecoration(
                  color: Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 25.0, left: 25, right: 25),
                  child: Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(width: 1, color: Colors.grey.withOpacity(0.2)),
                                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      widget.visitorAlreadyExists ?? false
                                          ? ClipRRect(
                                              borderRadius: BorderRadius.circular(5),
                                              child: Stack(
                                                children: [
                                                  SizedBox(
                                                    width: MediaQuery.of(context).size.width / 6,
                                                    child: CircleAvatar(
                                                      radius: 35,
                                                      backgroundImage: Image.asset(
                                                        '$icons_path/avatar.png',
                                                      ).image,
                                                    ),
                                                  ),
                                                  ClipRRect(
                                                    borderRadius: BorderRadius.circular(5),
                                                    child: (!(widget.mobileResponseData
                                                                    ?.profilePhoto
                                                                    .isNullOrEmpty() ??
                                                                false) ||
                                                            !(widget.mobileResponseData
                                                                    ?.profilePhoto
                                                                    .isNullOrEmpty() ??
                                                                false))
                                                        ? Image.network(
                                                            !(widget.mobileResponseData
                                                                        ?.profilePhoto
                                                                        .isNullOrEmpty() ??
                                                                    false)
                                                                ? '$googlePhotoUrl${getBucketName()}$voterPhotoFolder${widget.mobileResponseData?.profilePhoto}'
                                                                : '$googlePhotoUrl${getBucketName()}$visitorAadharFolder${widget.mobileResponseData?.aadharPhoto}',
                                                            fit: BoxFit.cover,
                                                          )
                                                        : Image.asset(
                                                            '$icons_path/avatar.png',
                                                            fit: BoxFit.cover,
                                                          ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          : const SizedBox(
                                              height: 10,
                                            ), // Empty space
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      widget.visitorAlreadyExists ?? false
                                          ? Text(
                                              capitalizedString(
                                                  widget.mobileResponseData?.fullName ??
                                                      'Not Available'),
                                              style:
                                                  text_style_title4.copyWith(color: Colors.black),
                                            )
                                          : Text(
                                              capitalizedString(widget.foreignerData?.fullName ??
                                                  'Not Available'),
                                              style:
                                                  text_style_title4.copyWith(color: Colors.black),
                                            ),

                                      const SizedBox(
                                        height: 10,
                                      ),
                                      RichText(
                                        text: TextSpan(
                                          children: [
                                            const TextSpan(
                                                text: 'Passport No', style: text_style_para1),
                                            const TextSpan(text: ': ', style: text_style_para1),
                                            widget.visitorAlreadyExists ?? false
                                                ? TextSpan(
                                                    text: widget.mobileResponseData
                                                            ?.visitorPassportNumber ??
                                                        'Not Available',
                                                    style: text_style_title13,
                                                  )
                                                : TextSpan(
                                                    text: widget.foreignerData?.passportNumber ??
                                                        'Not Available',
                                                    style: text_style_title13,
                                                  ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      RichText(
                                        text: TextSpan(
                                          children: [
                                            const TextSpan(
                                              text: 'Dob: ',
                                              style: text_style_para1,
                                            ),
                                            widget.visitorAlreadyExists ?? false
                                                ? TextSpan(
                                                    text: widget.mobileResponseData?.dob ??
                                                        'Not Available',
                                                    style: text_style_title13,
                                                  )
                                                : TextSpan(
                                                    text: widget.foreignerData?.dob ??
                                                        'Not Available',
                                                    style: text_style_title13,
                                                  ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      // RichText(
                                      //   text: TextSpan(
                                      //     children: [
                                      //       const TextSpan(
                                      //           text: 'Address: ',
                                      //           style: text_style_para1),
                                      //       widget.visitorAlreadyExists ?? false
                                      //           ? TextSpan(
                                      //               text: widget
                                      //                       .mobileResponseData
                                      //                       ?.address ??
                                      //                   'Not Available',
                                      //               style: text_style_title13,
                                      //             )
                                      //           : TextSpan(
                                      //               text: widget.foreignerData
                                      //                       ?.address ??
                                      //                   'Not Available',
                                      //               style: text_style_title13,
                                      //             ),
                                      //     ],
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                height: 50,
                                width: MediaQuery.of(context).size.width,
                                child: Button(
                                  text: 'Continue',
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      goToRoute(
                                        SecondFormProvider(
                                          child: AddVisitorSecondScreen(
                                            // visitorType:
                                            //     widget.visitor?.visitorType ??
                                            //         0,
                                            foreignerData: widget.foreignerData,
                                            mobileResponseData: widget.mobileResponseData,
                                            visitorType: 2,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  isRectangularBorder: true,
                                ),
                              ),
                            ],
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
