import 'dart:math';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/common/custom_widget/button.dart';
import 'package:host_visitor_connect/common/custom_widget/fields/form_error.dart';
import 'package:host_visitor_connect/common/custom_widget/title_bar_dialog.dart';
import 'package:host_visitor_connect/common/custom_widget/widget/qrCode_dialog.dart';
import 'package:host_visitor_connect/common/extensions/number_extensions.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:host_visitor_connect/common/blocs/state_events/ui_state.dart';
import 'package:host_visitor_connect/common/blocs/validator_bloc.dart';
import 'package:host_visitor_connect/common/custom_widget/app_bar_widget/title_bar.dart';
import 'package:host_visitor_connect/common/custom_widget/fields/add_form_field.dart';
import 'package:host_visitor_connect/common/extensions/string_extensions.dart';
import 'package:host_visitor_connect/common/res/keys.dart';
import 'package:host_visitor_connect/common/res/paths.dart';
import 'package:host_visitor_connect/common/res/styles.dart';
import 'package:host_visitor_connect/common/utils/app_function.dart';
import 'package:host_visitor_connect/common/utils/route_generator.dart';
import 'package:host_visitor_connect/features/visitors/add_visitor/bloc/aadhar_details_bloc.dart';
import 'package:host_visitor_connect/features/visitors/add_visitor/bloc/check_mobile_number_bloc.dart';
import 'package:host_visitor_connect/features/visitors/add_visitor/bloc/request_otp_bloc.dart';
import 'package:host_visitor_connect/features/visitors/add_visitor/data/network/response/mobile_response_data.dart';
import 'package:host_visitor_connect/features/visitors/add_visitor/ui/aadhar_details_screen.dart';
import 'package:host_visitor_connect/features/visitors/add_visitor/ui/aadhar_photo_provider.dart';
import 'package:host_visitor_connect/features/visitors/add_visitor/ui/model/add_indian_visitor.dart';
import 'package:host_visitor_connect/features/visitors/add_visitor/ui/otp_verification_screen.dart';
import 'package:host_visitor_connect/features/visitors/add_visitor/ui/request_otp_builder.dart';
import 'package:host_visitor_connect/features/visitors/add_visitor/ui/second_form_provider.dart';
import 'package:host_visitor_connect/features/visitors/add_visitor/ui1/add_visitor_second_screen.dart';
import 'package:host_visitor_connect/generated/l10n.dart';
import 'package:provider/provider.dart';

import 'add_aadhar_screen.dart';

class AddVisitorScreen extends StatefulWidget {
  final bool? visitorAlreadyExists;
  const AddVisitorScreen({super.key, this.visitorAlreadyExists});

  @override
  State<AddVisitorScreen> createState() => _AddVisitorScreenState();
}

class _AddVisitorScreenState extends State<AddVisitorScreen> {
  late TextEditingController _phoneTextFieldController;
  String? errorMsg = '';

  bool hasFocus = false;
  final focusNodeMobileNo = FocusNode();
  final focusNodeAadhar = FocusNode();

  @override
  void initState() {
    _phoneTextFieldController = TextEditingController();

    focusNodeMobileNo.addListener(() {
      setState(() {
        hasFocus = focusNodeMobileNo.hasFocus;
      });
    });
    focusNodeAadhar.addListener(() {
      setState(() {
        hasFocus = focusNodeAadhar.hasFocus;
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    _phoneTextFieldController.dispose();
    focusNodeMobileNo.dispose();
    focusNodeAadhar.dispose();
    super.dispose();
  }

  Widget updateVoterManuallyWidgetCallLogic() {
    final state = context.watch<CheckMobileNumberBloc>().state;
    if (state is Progress) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    if (state is Success) {
      if (state.getData()?.mobileResponseData?.id == null) {
        return addVoterManuallyFields();
      } else if (state.getData()?.mobileResponseData?.id != null) {
        return aadharData(state.getData()?.mobileResponseData, context);
      } else {
        return const SizedBox.shrink();
      }
    }
    return const SizedBox.shrink();
  }

  Widget aadharData(
      MobileResponseData? mobileResponseData, BuildContext context) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.grey.withOpacity(0.2)),
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Stack(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 6,
                            child: CircleAvatar(
                              radius: 35,
                              backgroundImage:
                                  Image.asset('$icons_path/avatar.png').image,
                            ),
                          ),
                          Positioned.fill(
                            child: (!(mobileResponseData?.aadharPhoto
                                            .isNullOrEmpty() ??
                                        false) ||
                                    !(mobileResponseData?.profilePhoto
                                            .isNullOrEmpty() ??
                                        false))
                                ? Image.network(
                                    !(mobileResponseData?.profilePhoto
                                                .isNullOrEmpty() ??
                                            false)
                                        ? '$googlePhotoUrl${getBucketName()}$voterPhotoFolder${mobileResponseData?.profilePhoto}'
                                        : '$googlePhotoUrl${getBucketName()}$visitorAadharFolder${mobileResponseData?.aadharPhoto}',
                                    fit: BoxFit.cover,
                                  )
                                : Image.asset(
                                    '$icons_path/avatar.png',
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    if (!(mobileResponseData?.qrImage.isNullOrEmpty() ?? false))
                      GestureDetector(
                        onTap: () {
                          QRCodeDialog.showQRCodeDialog(
                              context: context,
                              qrImage: mobileResponseData?.qrImage,
                              showShareButton: true);
                        },
                        child: Column(
                          children: [
                            Container(
                              width: 80,
                              height: 80,
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
                                  filter:
                                      ImageFilter.blur(sigmaX: 2, sigmaY: 2),
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
                  capitalizedString(
                      mobileResponseData?.fullName ?? 'Not Available'),
                  style: text_style_title4.copyWith(color: Colors.black),
                ),
                const SizedBox(
                  height: 10,
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                          text: 'Aadhar No', style: text_style_para1),
                      const TextSpan(text: ': ', style: text_style_para1),
                      TextSpan(
                        text:
                            mobileResponseData?.aadharNumber ?? 'Not Available',
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
                        text: 'Gender: ',
                        style: text_style_para1,
                      ),
                      TextSpan(
                        text: mobileResponseData?.gender?.getGender(),
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
                          text: 'Address: ', style: text_style_para1),
                      TextSpan(
                        text: capitalizedString(
                            mobileResponseData?.address ?? 'Not Available'),
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
          height: 10,
        ),
        // if (!(mobileResponseData?.expireDate.isNullOrEmpty() ?? false) &&
        //     isAfterToday(mobileResponseData?.expireDate ?? ''))
        SizedBox(
            width: MediaQuery.of(context).size.width,
            height: appSize(context: context, unit: 10) / 4.3,
            child: Button(
              isRectangularBorder: true,
              text: 'Update Aadhar',
              onPressed: () {
                Navigator.push(
                  context,
                  goToRoute(
                    AadharPhotoProvider(
                      child: AddAadharScreen(
                        mobileResponseData: mobileResponseData,
                      ),
                    ),
                  ),
                );
              },
            )),
        if (!(errorMsg.isNullOrEmpty()) &&
            context.read<RequestOtpBloc>().state is! Progress &&
            context.read<RequestOtpBloc>().state.getData()?.status != 200)
          const SizedBox(
            height: 30,
          ),
        if (!(errorMsg.isNullOrEmpty()) &&
            context.read<RequestOtpBloc>().state is! Progress &&
            context.read<RequestOtpBloc>().state.getData()?.status != 200)
          Container(
            padding: const EdgeInsets.symmetric(vertical: 18),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: Colors.red.withOpacity(0.2),
            ),
            alignment: Alignment.center,
            child: FittedBox(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  errorMsg ?? '',
                  style: const TextStyle(color: Colors.red),
                ),
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
            isRectangularBorder: true,
            text: 'Next',
            onPressed: () {
              Navigator.push(
                context,
                goToRoute(
                  SecondFormProvider(
                    child: AddVisitorSecondScreen(
                      updateIndianVisitor: true,
                      visitorType: mobileResponseData?.visitorType ?? 0,
                      mobileResponseData: mobileResponseData,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const TitleBar(title: 'Add Visitor'),
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
                padding: const EdgeInsets.only(
                  top: 25.0,
                  left: 25,
                  right: 25,
                  bottom: 15,
                ),
                child: FormBuilder(
                  key: context.read<GlobalKey<FormBuilderState>>(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BlocProvider(
                        create: (context) => ValidatorOnChanged(),
                        child: BlocBuilder<ValidatorOnChanged, String>(
                          builder: (context, state) {
                            return Column(
                              children: [
                                AddFormField(
                                  label: 'Mobile No',
                                  isMobileNumber: true,
                                  focusNode: focusNodeMobileNo,
                                  countryCode: '91',
                                  hintText: 'Enter Mobile Number',
                                  errorMsg: state,
                                  maxLength: 10,
                                  isEnable: (context
                                          .watch<RequestOtpBloc>()
                                          .state is Progress)
                                      ? false
                                      : true,
                                  onChanged: (phoneNo) {
                                    context
                                        .read<ValidatorOnChanged>()
                                        .validateMobile(phoneNo, context);
                                    if (RegExp(r'[5-9][0-9]{9}')
                                            .hasMatch(phoneNo) &&
                                        _phoneTextFieldController.text.length ==
                                            10) {
                                      FocusScope.of(context).unfocus();

                                      context
                                          .read<AddIndianVisitor>()
                                          .mobileNumber = phoneNo;

                                      context
                                          .read<CheckMobileNumberBloc>()
                                          .checkMobileNumber(
                                            mobileNo: phoneNo,
                                          );
                                    }
                                  },
                                  controller: _phoneTextFieldController,
                                  validator: (value) {
                                    if (value?.isEmpty ?? false) {
                                      return S
                                          .of(context)
                                          .mobileNoValidation_label_pleaseEnterMobileNumber;
                                    }
                                    if (!RegExp(r'[5-9][0-9]{9}')
                                        .hasMatch(value ?? '')) {
                                      return S
                                          .of(context)
                                          .mobileNoValidation_label_pleaseEnterValidMobileNumber;
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      updateVoterManuallyWidgetCallLogic(),
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

  addVoterManuallyFields() {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocProvider(
              create: (context) => ValidatorOnChanged(),
              child: BlocBuilder<ValidatorOnChanged, String>(
                builder: (context, state) {
                  return AddFormField(
                    isEnable:
                        (context.watch<RequestOtpBloc>().state is Progress)
                            ? false
                            : true,
                    errorMsg: state,
                    focusNode: focusNodeAadhar,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp(r'\d|\s'),
                      ),
                      AadharInputFormatter(inputLength: 12),
                    ],
                    keyboardType: TextInputType.number,
                    hintText: 'Enter Aadhar No',
                    label: 'Aadhar No',
                    onChanged: (aadharNo) {
                      context
                          .read<ValidatorOnChanged>()
                          .validateAadhar(aadharNo);

                      context.read<AddIndianVisitor>().aadharNumber =
                          aadharNo.replaceAll(" ", "");
                    },
                    validator: (value) {
                      if (value?.isEmpty ?? false) {
                        return 'Please enter Aadhar No';
                      }
                      if (!RegExp(r'^[2-9][0-9]{3}[0-9]{4}[0-9]{4}$')
                          .hasMatch(value?.replaceAll(" ", "") ?? '')) {
                        return 'Please enter valid Aadhar No';
                      }
                      return null;
                    },
                  );
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: RequestOtpBuilder(
                buttonName: 'Request OTP',
                onSuccess: () {
                  final aadharData =
                      context.read<RequestOtpBloc>().state.getData();

                  if (aadharData?.isOtp == 1) {
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
                            isOldVisitor: false,
                            aadharData: aadharData,
                          ),
                        ),
                      ),
                    );
                  } else if (aadharData?.isOtp == 0) {
                    Navigator.push(
                      context,
                      goToRoute(
                        MultiProvider(
                          providers: [
                            BlocProvider(
                              create: (_) => RequestOtpBloc(),
                            ),
                          ],
                          child: AadharDetailsScreen(
                            isOldVisitor: true,
                            otpGenerationResponse: aadharData,
                            phoneNo:
                                context.read<AddIndianVisitor>().mobileNumber,
                          ),
                        ),
                      ),
                    );
                  }
                },
                onGenerateOtpPressed: () {
                  if (FormErrorBuilder.validateFormAndShowErrors(context) &&
                      !context
                          .read<AddIndianVisitor>()
                          .mobileNumber
                          .isNullOrEmpty() &&
                      !context
                          .read<AddIndianVisitor>()
                          .aadharNumber
                          .isNullOrEmpty()) {
                    context.read<RequestOtpBloc>().requestOtp(
                          mobileNo:
                              context.read<AddIndianVisitor>().mobileNumber ??
                                  '',
                          aadharNo:
                              context.read<AddIndianVisitor>().aadharNumber ??
                                  '',
                          update: 0,
                          id: 0,
                        );
                  }
                },
                aadharerror: (error) {
                  errorMsg = error;
                  setState(() {});
                },
              ),
            ),
            if (!(errorMsg.isNullOrEmpty()) &&
                context.read<RequestOtpBloc>().state is! Progress &&
                context.read<RequestOtpBloc>().state.getData()?.status != 200)
              const SizedBox(
                height: 30,
              ),
            if (!(errorMsg.isNullOrEmpty()) &&
                context.read<RequestOtpBloc>().state is! Progress &&
                context.read<RequestOtpBloc>().state.getData()?.status != 200)
              Container(
                padding: const EdgeInsets.symmetric(vertical: 18),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.red.withOpacity(0.2),
                ),
                alignment: Alignment.center,
                child: FittedBox(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      errorMsg ?? '',
                      style: const TextStyle(color: Colors.red),
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

class AadharInputFormatter extends TextInputFormatter {
  final int? inputLength;

  AadharInputFormatter({
    this.inputLength,
  });

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String left = oldValue.text
        .substring(0, min(oldValue.selection.start, newValue.selection.end));
    String right = oldValue.text.substring(oldValue.selection.end);
    String inserted =
        newValue.text.substring(left.length, newValue.selection.end);
    String modLeft = left.replaceAll(" ", "");
    String modRight = right.replaceAll(" ", "");
    String modInserted = inserted.replaceAll(" ", "");
    if (inputLength != null) {
      modInserted = modInserted.substring(
          0,
          min(inputLength! - modLeft.length - modRight.length,
              modInserted.length));
    }
    final regEx = RegExp(r'\d{1,4}');
    String updated = regEx
        .allMatches((modLeft + modInserted + modRight).toUpperCase())
        .map((e) => e.group(0))
        .join(" ");
    int cursorPosition = regEx
        .allMatches(modLeft + modInserted)
        .map((e) => e.group(0))
        .join(" ")
        .length;
    return TextEditingValue(
      text: updated,
      selection: TextSelection.collapsed(offset: cursorPosition),
    );
  }
}
