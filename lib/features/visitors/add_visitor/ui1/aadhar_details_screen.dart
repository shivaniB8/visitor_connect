import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/common/custom_widget/app_bar_widget/title_bar.dart';
import 'package:host_visitor_connect/common/extensions/string_extensions.dart';
import 'package:host_visitor_connect/common/res/keys.dart';
import 'package:host_visitor_connect/common/res/paths.dart';
import 'package:host_visitor_connect/common/res/styles.dart';
import 'package:host_visitor_connect/common/utils/route_generator.dart';
import 'package:host_visitor_connect/features/visitors/add_visitor/bloc/aadhar_details_bloc.dart';
import 'package:host_visitor_connect/features/visitors/add_visitor/bloc/request_otp_bloc.dart';
import 'package:host_visitor_connect/features/visitors/add_visitor/data/network/response/foreigner_data.dart';
import 'package:host_visitor_connect/features/visitors/add_visitor/data/network/response/mobile_response_data.dart';
import 'package:host_visitor_connect/features/visitors/add_visitor/data/network/response/otp_generation_response.dart';
import 'package:host_visitor_connect/features/visitors/add_visitor/ui1/add_visitor_second_screen.dart';
import 'package:host_visitor_connect/features/visitors/add_visitor/ui1/request_otp_builder.dart';
import 'package:host_visitor_connect/features/visitors/add_visitor/ui1/second_form_provider.dart';
import 'package:provider/provider.dart';

import '../../../../../../common/custom_widget/button.dart';
import 'otp_verification_screen.dart';

class AadharDetailsScreen extends StatefulWidget {
  final bool? visitorAlreadyExists;

  final OtpGenerationResponse? otpGenerationResponse;
  final MobileResponseData? mobileResponseData;
  final ForeignerData? foreignerData;
  final bool? isForeigner;
  final String? phoneNo;
  final bool? otpVerified;
  final bool? isOldVisitor;

  const AadharDetailsScreen(
      {super.key,
      this.otpGenerationResponse,
      this.mobileResponseData,
      this.foreignerData,
      this.isForeigner,
      this.visitorAlreadyExists,
      this.phoneNo,
      this.otpVerified,
      this.isOldVisitor});

  @override
  State<AadharDetailsScreen> createState() => _AadharDetailsScreenState();
}

class _AadharDetailsScreenState extends State<AadharDetailsScreen> {
  String? errorMsg = '';
  MobileResponseData? mobileResponseData;
  OtpGenerationResponse? otpGenerationResponse;

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
              title: 'Aadhar Details',
              isBack: false,
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
                                      if (!(widget.isForeigner ?? false))
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(5),
                                          child: (!(widget.otpGenerationResponse?.data
                                                          ?.aadharDataResponse?.aadharPhoto
                                                          ?.isNullOrEmpty() ??
                                                      false) ||
                                                  !(widget.otpGenerationResponse?.data
                                                          ?.aadharDataResponse?.profilePhoto
                                                          .isNullOrEmpty() ??
                                                      false))
                                              ? Image.network(
                                                  (widget.otpGenerationResponse?.data
                                                              ?.aadharDataResponse?.profilePhoto
                                                              .isNullOrEmpty() ??
                                                          false)
                                                      ? '$googlePhotoUrl${getBucketName()}$visitorAadharFolder${widget.otpGenerationResponse?.data?.aadharDataResponse?.aadharPhoto}'
                                                      : '$googlePhotoUrl${getBucketName()}$voterPhotoFolder${widget.otpGenerationResponse?.data?.aadharDataResponse?.profilePhoto}'
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
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      if (!(widget.isForeigner ?? false))
                                        Text(
                                          capitalizedString(widget.otpGenerationResponse?.data
                                                  ?.aadharDataResponse?.aadharName ??
                                              'Not Available'),
                                          style: text_style_title4.copyWith(color: Colors.black),
                                        ),
                                      if ((widget.isForeigner ?? false))
                                        Text(
                                          capitalizedString(
                                              widget.foreignerData?.fullName ?? 'Not Available'),
                                          style: text_style_title4.copyWith(color: Colors.black),
                                        ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      if (!(widget.isForeigner ?? false))
                                        RichText(
                                          text: TextSpan(
                                            children: [
                                              const TextSpan(
                                                  text: 'Aadhar No', style: text_style_para1),
                                              const TextSpan(text: ': ', style: text_style_para1),
                                              TextSpan(
                                                text: widget.otpGenerationResponse?.data
                                                        ?.aadharDataResponse?.aadharNumber ??
                                                    'Not Available',
                                                style: text_style_title13,
                                              ),
                                            ],
                                          ),
                                        ),
                                      if ((widget.isForeigner ?? false))
                                        RichText(
                                          text: TextSpan(
                                            children: [
                                              const TextSpan(
                                                  text: 'Passport No', style: text_style_para1),
                                              const TextSpan(text: ': ', style: text_style_para1),
                                              TextSpan(
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
                                      if (!(widget.isForeigner ?? false))
                                        RichText(
                                          text: TextSpan(
                                            children: [
                                              const TextSpan(
                                                text: 'Gender: ',
                                                style: text_style_para1,
                                              ),
                                              // TextSpan(
                                              //   text: widget
                                              //       .otpGenerationResponse
                                              //       ?.data
                                              //       ?.aadharDataResponse
                                              //       ?.gender?.getGender(),
                                              //   style: text_style_title13,
                                              // ),
                                            ],
                                          ),
                                        ),
                                      if ((widget.isForeigner ?? false))
                                        RichText(
                                          text: TextSpan(
                                            children: [
                                              const TextSpan(
                                                  text: 'Date of Birth: ', style: text_style_para1),
                                              TextSpan(
                                                text: capitalizedString(
                                                    widget.foreignerData?.dob ?? 'Not Available'),
                                                style: text_style_title13,
                                              ),
                                            ],
                                          ),
                                        ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      if (!(widget.isForeigner ?? false))
                                        RichText(
                                          text: TextSpan(
                                            children: [
                                              const TextSpan(
                                                  text: 'Address: ', style: text_style_para1),
                                              TextSpan(
                                                text: capitalizedString(widget.otpGenerationResponse
                                                        ?.data?.aadharDataResponse?.aadharAddress ??
                                                    'Not Available'),
                                                style: text_style_title13,
                                              ),
                                            ],
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              widget.otpVerified ?? false
                                  ? const SizedBox.shrink() // if verified, show empty box
                                  : SizedBox(
                                      height: 50,
                                      width: MediaQuery.of(context).size.width,
                                      child: BlocProvider.value(
                                        value: context.read<RequestOtpBloc>(),
                                        child: RequestOtpBuilder(
                                          buttonName: 'Update Aadhaar',
                                          onGenerateOtpPressed: () {
                                            context.read<RequestOtpBloc>().requestOtp(
                                                mobileNo: widget.phoneNo ?? '',
                                                aadharNo: widget.otpGenerationResponse?.data
                                                        ?.aadharDataResponse?.aadharNumber ??
                                                    '',
                                                update: 1,
                                                id: widget.otpGenerationResponse?.data
                                                        ?.aadharDataResponse?.visitorFk ??
                                                    0);
                                          },
                                          onSuccess: () {
                                            if (context
                                                    .read<RequestOtpBloc>()
                                                    .state
                                                    .getData()
                                                    ?.status ==
                                                200) {
                                              Navigator.push(
                                                context,
                                                goToRoute(
                                                  MultiProvider(
                                                    providers: [
                                                      BlocProvider(
                                                        create: (_) => AadharDetailsBloc(),
                                                      ),
                                                      BlocProvider(
                                                        create: (_) => RequestOtpBloc(),
                                                      ),
                                                    ],
                                                    child: VerifyOtpScreen(
                                                      otpVerified: true,
                                                      aadharData: context
                                                          .read<RequestOtpBloc>()
                                                          .state
                                                          .getData(),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }
                                          },
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
                                            visitorType: 1,
                                            otpGenerationResponse: widget.otpGenerationResponse,
                                          ),
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
