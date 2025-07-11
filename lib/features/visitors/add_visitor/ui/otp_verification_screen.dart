import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/common/app_toast.dart';
import 'package:host_visitor_connect/common/blocs/state_events/ui_state.dart';
import 'package:host_visitor_connect/common/custom_widget/app_bar_widget/title_bar.dart';
import 'package:host_visitor_connect/common/custom_widget/button.dart';
import 'package:host_visitor_connect/common/utils/route_generator.dart';
import 'package:host_visitor_connect/common/utils/toast_utils.dart';
import 'package:host_visitor_connect/features/visitors/add_visitor/bloc/aadhar_details_bloc.dart';
import 'package:host_visitor_connect/features/visitors/add_visitor/bloc/request_otp_bloc.dart';
import 'package:host_visitor_connect/features/visitors/add_visitor/data/network/response/otp_generation_response.dart';
import 'package:host_visitor_connect/features/visitors/add_visitor/ui/aadhar_photo_provider.dart';
import 'package:host_visitor_connect/features/visitors/add_visitor/ui/aadhar_photo_screen.dart';
import 'package:host_visitor_connect/features/visitors/add_visitor/ui/otp_verification_builder.dart';
import 'package:host_visitor_connect/common/res/colors.dart';
import 'package:host_visitor_connect/common/res/styles.dart';
import 'package:host_visitor_connect/features/visitors/add_visitor/ui/second_form_provider.dart';
import 'package:sms_autofill/sms_autofill.dart';

import 'aadhar_details_screen.dart';

class VerifyOtpScreen extends StatefulWidget {
  final OtpGenerationResponse? aadharData;
  final bool? otpVerified;
  final bool? isOldVisitor;
  final bool? visitorAlreadyExists;

  const VerifyOtpScreen(
      {Key? key,
      this.aadharData,
      this.otpVerified,
      this.isOldVisitor,
      this.visitorAlreadyExists})
      : super(key: key);

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  int secondsRemaining = 120;
  bool enableResend = false;
  late Timer timer;
  late TextEditingController _codeController;
  bool showErrorPlate = false;
  bool isButtonEnabled = false;
  late int _secondsRemaining;
  bool _otpIsWrongDisableTextField = false;
  Timer? _disableTimer;

  @override
  void initState() {
    super.initState();
    _codeController = TextEditingController();
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (secondsRemaining != 0) {
        setState(() {
          secondsRemaining--;
        });
      } else {
        setState(() {
          enableResend = true;
        });
      }
    });
    startTimer();
    startDisableTimer();
  }

  void startDisableTimer() {
    const duration = Duration(minutes: 1); // 1 minute duration
    _disableTimer = Timer(duration, () {
      setState(() {
        _otpIsWrongDisableTextField =
            true; // Disable the text field after 1 minute
      });
    });
  }

  void startTimer() {
    _secondsRemaining = widget.aadharData?.timer ??
        0; // Initialize _secondsRemaining with API value
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--;
        });
      } else {
        setState(() {
          isButtonEnabled = true;
        });
        timer.cancel(); // Stop the timer when it reaches 0
      }
    });
  }

  bool otpIsWrongDisable = false;

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
    _disableTimer?.cancel();
  }

  Color _getResendOtpLabelColor() {
    if (enableResend) {
      return buttonColor;
    } else {
      return gray_color;
    }
  }

  @override
  Widget build(BuildContext context) {
    String printDuration(Duration duration) {
      String twoDigits(int n) => n.toString().padLeft(2, "0");
      String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
      String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
      return "$twoDigitMinutes:$twoDigitSeconds";
    }

    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: IgnorePointer(
          ignoring: false,
          child: Stack(
            children: [
              const TitleBar(
                title: 'Verify Aadhar OTP',
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
                    padding:
                        const EdgeInsets.only(top: 25.0, left: 25, right: 25),
                    child: SingleChildScrollView(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Aadhar: ${widget.aadharData?.data?.aadharNumber}',
                                  style: text_style_title13.copyWith(
                                      fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                GestureDetector(
                                  child: Text(
                                    'Change',
                                    style: text_style_title11.copyWith(
                                        color: buttonColor),
                                  ),
                                  onTap: () {
                                    if (context.read<AadharDetailsBloc>().state
                                        is! Progress) {
                                      Navigator.of(context).pop();
                                    }
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'One time password (OTP) has been sent to mobile number ending with ${widget.aadharData?.data?.lastDigits ?? 'Not Available'}',
                              style: text_style_para1.copyWith(
                                  color: Colors.black54),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              'Enter OTP',
                              style: text_style_title13,
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            PinFieldAutoFill(
                              key: const Key('otp'),
                              cursor: Cursor(
                                color: (context.watch<AadharDetailsBloc>().state
                                        is Progress)
                                    ? Colors.grey
                                    : buttonColor,
                                enabled: true,
                                width: 2.0,
                                blinkHalfPeriod: const Duration(seconds: 1),
                              ),
                              enabled: !(context
                                          .watch<AadharDetailsBloc>()
                                          .state is Progress) &&
                                      (!_otpIsWrongDisableTextField &&
                                          !otpIsWrongDisable)
                                  ? true
                                  : false,
                              autoFocus: true,
                              decoration: BoxLooseDecoration(
                                textStyle: TextStyle(
                                  fontSize: 18,
                                  color: _otpIsWrongDisableTextField
                                      ? Colors.grey
                                      : Colors.black,
                                ),
                                radius: const Radius.circular(5),
                                gapSpace: 10,
                                strokeWidth: 2.0,
                                strokeColorBuilder: PinListenColorBuilder(
                                  _otpIsWrongDisableTextField
                                      ? Colors.grey
                                      : (context
                                                  .watch<AadharDetailsBloc>()
                                                  .state is Progress ||
                                              (context
                                                      .read<AadharDetailsBloc>()
                                                      .state
                                                      .getData()
                                                      ?.success ==
                                                  false))
                                          ? Colors.grey
                                          : buttonColor,
                                  _otpIsWrongDisableTextField
                                      ? Colors.grey
                                      : buttonColor,
                                ),
                              ),
                              currentCode: _codeController.text,
                              controller: _codeController,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9]')),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: OtpVerificationBuilder(
                                onWrongOtp: () {
                                  if (context
                                          .read<AadharDetailsBloc>()
                                          .state
                                          .getData()
                                          ?.success ==
                                      false) {
                                    showErrorPlate = true;
                                    _codeController.clear();
                                    secondsRemaining = 0;
                                    enableResend = true;
                                    otpIsWrongDisable = true;
                                  } else {
                                    enableResend = false;
                                    otpIsWrongDisable = false;
                                  }
                                  setState(() {});
                                },
                                onVerifyOtpPressed: () {
                                  if (_codeController.text.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Please enter OTP'),
                                      ),
                                    );
                                    return;
                                  } else if (_codeController.text.length != 6) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content:
                                            Text('Please enter a 6-digit OTP'),
                                      ),
                                    );
                                    return;
                                  }
                                  context
                                      .read<AadharDetailsBloc>()
                                      .getAadharDetails(
                                        mobileNo: widget.aadharData?.data
                                                ?.mobileNumber ??
                                            '',
                                        aadharNo: widget.aadharData?.data
                                                ?.aadharNumber ??
                                            '',
                                        update: 1,
                                        id: widget.aadharData?.data?.id ?? 0,
                                        otp: _codeController.text,
                                      );
                                },
                                onSuccess: () {
                                  if (context
                                          .read<AadharDetailsBloc>()
                                          .state
                                          .getData()
                                          ?.status ==
                                      200) {
                                    Navigator.of(context).push(
                                      goToRoute(
                                        SecondFormProvider(
                                          child: AadharDetailsScreen(
                                            isOldVisitor: (widget.isOldVisitor),
                                            otpVerified: true,
                                            phoneNo: widget
                                                .aadharData?.data?.mobileNumber,
                                            otpGenerationResponse: context
                                                .read<AadharDetailsBloc>()
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
                            const SizedBox(
                              height: 15,
                            ),
                            (!showErrorPlate)
                                ? const SizedBox()
                                : Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 18),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.0),
                                      color: Colors.red.withOpacity(0.2),
                                    ),
                                    alignment: Alignment.center,
                                    child: const Text(
                                      'Enter Correct OTP',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    if (enableResend) {
                                      context
                                          .read<AadharDetailsBloc>()
                                          .clearState();

                                      context.read<RequestOtpBloc>().requestOtp(
                                            id: widget.aadharData?.data?.id ??
                                                0,
                                            update: 1,
                                            mobileNo: widget.aadharData?.data
                                                    ?.mobileNumber ??
                                                '',
                                            aadharNo: widget.aadharData?.data
                                                    ?.aadharNumber ??
                                                '',
                                          );
                                      setState(() {
                                        secondsRemaining = 120;
                                        _otpIsWrongDisableTextField =
                                            false; // Update to enable the PinFieldAutoFill
                                        enableResend = false;
                                        showErrorPlate = false;
                                      });
                                    } else {
                                      ToastUtils().showToast(
                                        context,
                                        message: 'OTP already Sent',
                                        toastStatus: ToastStatus.invalid,
                                      );
                                    }
                                  },
                                  child: Text(
                                    'Resend OTP',
                                    style: text_style_para1.copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: _getResendOtpLabelColor(),
                                      fontSize: 14,
                                    ),
                                  ),
                                ),

                                // White space
                                const SizedBox(
                                  width: 5,
                                ),

                                secondsRemaining == 0
                                    ? const SizedBox()
                                    : Text(
                                        'in ${printDuration(Duration(seconds: secondsRemaining))}',
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                        ),
                                      ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              height: 40,
                              child: Center(
                                  child: isButtonEnabled
                                      ? Button(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              goToRoute(
                                                AadharPhotoProvider(
                                                  child: AadharPhotoScreen(
                                                    aadharData:
                                                        widget.aadharData,
                                                    // isFromDocument: true,
                                                  ),
                                                ),
                                              ),
                                              // MaterialPageRoute(
                                              //   builder: (context) =>
                                              //       AadharPhotoProvider(
                                              //     child: AadharPhotoScreen(
                                              //       aadharData:
                                              //           widget.aadharData,
                                              //       // isFromDocument: true,
                                              //     ),
                                              //   ),
                                              // ),
                                            );
                                          },
                                          child: Text(
                                            'Submit Document',
                                            style: text_style_title5.copyWith(
                                              color: Colors.white,
                                            ),
                                          ),
                                        )
                                      : const SizedBox.shrink()),
                            )
                          ]),
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
