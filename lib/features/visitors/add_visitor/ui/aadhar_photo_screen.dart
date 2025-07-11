import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:host_visitor_connect/common/custom_widget/app_bar_widget/custom_widget_image_app_bar.dart';
import 'package:host_visitor_connect/common/custom_widget/app_success_page.dart';

import 'package:host_visitor_connect/common/custom_widget/fields/form_error.dart';
import 'package:host_visitor_connect/common/res/colors.dart';
import 'package:host_visitor_connect/common/res/paths.dart';

import 'package:host_visitor_connect/common/res/styles.dart';
import 'package:host_visitor_connect/common/upload_image.dart';
import 'package:host_visitor_connect/common/utils/route_generator.dart';
import 'package:host_visitor_connect/features/qr/data/network/responses/qr_scanner_data_response.dart';
import 'package:host_visitor_connect/features/qr/ui/qr_scannerd_visitor.dart';
import 'package:host_visitor_connect/features/report/report_list/ui/model/report.dart';
import 'package:host_visitor_connect/features/visitors/add_visitor/bloc/blood_grp_bloc.dart';
import 'package:host_visitor_connect/features/visitors/add_visitor/bloc/visitor_document_bloc.dart';
import 'package:host_visitor_connect/features/visitors/add_visitor/data/network/response/foreigner_data.dart';
import 'package:host_visitor_connect/features/visitors/add_visitor/data/network/response/otp_generation_response.dart';
import 'package:host_visitor_connect/features/visitors/add_visitor/ui1/add_visitor_second_screen.dart';
import 'package:host_visitor_connect/features/visitors/add_visitor/ui1/second_form_provider.dart';

import 'package:host_visitor_connect/features/visitors/visitor_listing/blocs/outgoing_call_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'visitor_document_builder.dart';

class AadharPhotoScreen extends StatefulWidget {
  final QrScannerDataResponse? visitor;
  final OtpGenerationResponse? aadharData;

  final Report? report;
  final bool? isForeigner;
  final bool? isOldVisitor;
  final bool? isFromScan;
  final int? visitorId;
  final int? businessType;
  final ForeignerData? foreignerData;

  const AadharPhotoScreen(
      {super.key,
      this.visitor,
      this.aadharData,
      this.isForeigner,
      this.isOldVisitor,
      this.visitorId,
      this.foreignerData,
      this.isFromScan,
      this.businessType,
      this.report});

  @override
  State<AadharPhotoScreen> createState() => _AadharPhotoScreenState();
}

class _AadharPhotoScreenState extends State<AadharPhotoScreen> {
  XFile? aadharFront;
  XFile? aadharBack;
  XFile? licenceFront;
  XFile? licenceBack;
  String? errorMsg;

  bool validateInputs() {
    // Perform validation checks here
    if (aadharFront == null) {
      Text(
        'Please upload Front Driving Licence images',
        style: AppStyle.bodyMedium(context).copyWith(color: Colors.red),
      );
    }
    // Add more validation checks as needed
    return true; // Return true if all validations pass
  }

  @override
  Widget build(BuildContext context) {
    print("Driving Licence Details visitorId");
    print(widget.visitorId);
    return Scaffold(
      appBar: CustomImageAppBar(
        title: 'Driving Licence Details',
        context: context,
        showSettings: false,
        showEditIcon: false,
      ),
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              color: Color(0xFFFFFFFF),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                top: 25.0,
                left: 25,
                right: 25,
                bottom: 15,
              ),
              child: SingleChildScrollView(
                child: FormBuilder(
                  key: context.read<GlobalKey<FormBuilderState>>(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      UploadImage(
                        isEnable: true, // Enable only if an image is selected
                        onImageSelected: (image) {
                          setState(() {
                            aadharFront = image;
                          });
                          Navigator.pop(context);
                        },
                        child: Column(
                          children: [
                            Container(
                              height: 50,
                              width: MediaQuery.of(context).size.width / 2,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.blueAccent.withOpacity(0.2),
                              ),
                              child: const Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.upload,
                                      color: buttonColor,
                                      size: 20,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'Driving Licence Front \n Side Photo',
                                          // widget.isForeigner == true
                                          //     ? 'Driving Licence Front \n Side Photo'
                                          //     : 'Aadhar Front Side Photo',
                                          style: text_style_title5,
                                        ),
                                        Text(
                                          '*', // Mandatory symbol
                                          style: TextStyle(
                                            color: Colors
                                                .red, // Color of the symbol
                                            fontSize: 20, // Size of the symbol
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            if (aadharFront?.path.isNotEmpty ?? false)
                              SizedBox(
                                height: MediaQuery.of(context).size.height / 5,
                                width: MediaQuery.of(context).size.width,
                                child: (aadharFront?.name.contains(".png") ??
                                            false) ||
                                        (aadharFront?.name.contains(".jpg") ??
                                            false) ||
                                        (aadharFront?.name.contains(".jpeg") ??
                                            false)
                                    ? ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(6.0),
                                        child: Image.file(
                                          File(aadharFront?.path ?? ''),
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    : const SizedBox(
                                        height: 100,
                                      ),
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      UploadImage(
                        isEnable: true,
                        onImageSelected: (image) {
                          setState(() {
                            aadharBack = image;
                          });
                          Navigator.pop(context);
                        },
                        child: Column(
                          children: [
                            Container(
                              height: 50,
                              width: MediaQuery.of(context).size.width / 2,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.blueAccent.withOpacity(0.2),
                              ),
                              child: const Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.upload,
                                      color: buttonColor,
                                      size: 20,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      'Driving Licence Back\n Side Photo',
                                      // widget.isForeigner == true
                                      //     ? 'Driving Licence Back\n Side Photo'
                                      //     : 'Aadhar Back Side Photo',
                                      style: text_style_title5,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            if (aadharBack?.path.isNotEmpty ?? false)
                              SizedBox(
                                height: MediaQuery.of(context).size.height / 5,
                                width: MediaQuery.of(context).size.width,
                                child: (aadharBack?.name.contains(".png") ??
                                            false) ||
                                        (aadharBack?.name.contains(".jpg") ??
                                            false) ||
                                        (aadharBack?.name.contains(".jpeg") ??
                                            false)
                                    ? ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(6.0),
                                        child: Image.file(
                                          File(aadharBack?.path ?? ''),
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    : const SizedBox.shrink(),
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 40,
                        child: VisitorDocumentBuilder(
                          onSuccess: () {
                            if (widget.isForeigner == true &&
                                widget.isFromScan == true) {
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
                                      visitor: widget.visitor,
                                    ),
                                  ),
                                ),
                              );
                            } else if (widget.isForeigner == true) {
                              Navigator.pushReplacement(
                                context,
                                goToRoute(
                                  const SuccessAppScreen(
                                    showBackButton: false,
                                    img: '$icons_path/Group.png',
                                    title: 'Congratulations!',
                                    subtitle:
                                        "Visitor has been added successfully'",
                                  ),
                                ),
                              );
                            } else {
                              Navigator.push(
                                context,
                                goToRoute(
                                  SecondFormProvider(
                                    child: AddVisitorSecondScreen(
                                      visitorType: 1,
                                      otpGenerationResponse: widget.aadharData,
                                      isAaddharDocument: true,
                                    ),
                                  ),
                                ),
                              );
                            }
                          },
                          onSubmitPressed: () {
                            if (FormErrorBuilder.validateFormAndShowErrors(
                                context)) {
                              // if (widget.isForeigner == true) {

                              if (validateInputs()) {
                                context
                                    .read<VisitorDocumentBloc>()
                                    .drivingLicenceDocuments(
                                      licenceBack: aadharBack,
                                      licenceFront: aadharFront,
                                      visitorId: widget.visitorId ?? 0,
                                    );
                              }
                              // }
                              // else if (validateInputs()) {
                              //   context
                              //       .read<VisitorDocumentBloc>()
                              //       .visitorDocuments(
                              //         aadharBack: aadharBack,
                              //         aadharFront: aadharFront,
                              //         visitorId:
                              //             widget.aadharData?.data?.id ?? 0,
                              //       );
                              // }
                            }
                          },
                          onError: (error) {
                            setState(() {
                              errorMsg = error;
                            });
                          },
                        ),
                      ),
                      if (context
                              .read<VisitorDocumentBloc>()
                              .state
                              .getData()
                              ?.success ==
                          false)
                        const SizedBox(
                          height: 10,
                        ),
                      if (context
                              .read<VisitorDocumentBloc>()
                              .state
                              .getData()
                              ?.success ==
                          false)
                        Container(
                          height: 40,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Colors.red.withOpacity(0.2),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              errorMsg ?? '',
                              style: text_style_title5.copyWith(
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
