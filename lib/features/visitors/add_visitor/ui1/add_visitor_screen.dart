import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:host_visitor_connect/common/app_toast.dart';
import 'package:host_visitor_connect/common/blocs/validator_bloc.dart';
import 'package:host_visitor_connect/common/custom_widget/app_action_dilog.dart';
import 'package:host_visitor_connect/common/custom_widget/app_bar_widget/custom_widget_image_app_bar.dart';
import 'package:host_visitor_connect/common/custom_widget/dots_progress_button.dart';
import 'package:host_visitor_connect/common/custom_widget/fields/add_form_field.dart';
import 'package:host_visitor_connect/common/custom_widget/fields/form_error.dart';
import 'package:host_visitor_connect/common/custom_widget/fields/form_field_label.dart';
import 'package:host_visitor_connect/common/custom_widget/loading.dart';
import 'package:host_visitor_connect/common/res/colors.dart';
import 'package:host_visitor_connect/common/res/paths.dart';
import 'package:host_visitor_connect/common/res/styles.dart';
import 'package:host_visitor_connect/common/utils/route_generator.dart';
import 'package:host_visitor_connect/common/utils/toast_utils.dart';
import 'package:host_visitor_connect/common/utils/utils.dart';
import 'package:host_visitor_connect/features/visitors/add_visitor/bloc/aadhar_details_bloc.dart';
import 'package:host_visitor_connect/features/visitors/add_visitor/bloc/request_otp_bloc.dart';
import 'package:host_visitor_connect/features/visitors/add_visitor/ui1/request_otp_builder.dart';
import 'package:host_visitor_connect/features/visitors/add_visitor/ui1/resend_otp_builder.dart';
import 'package:host_visitor_connect/generated/l10n.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'aadhar_details.dart';
import 'add_visitor_details.dart';
import 'otp_verification_builder.dart';

class AddVisitorScreen extends StatefulWidget {
  final bool? visitorAlreadyExists;
  const AddVisitorScreen({super.key, this.visitorAlreadyExists});

  @override
  State<AddVisitorScreen> createState() => _AddVisitorScreenState();
}

class _AddVisitorScreenState extends State<AddVisitorScreen> {
  UniqueKey pinCodeKey = UniqueKey();
  final TextEditingController _phoneTextFieldController =
      TextEditingController();
  final TextEditingController _aadharTextFieldController =
      TextEditingController();
  String currentPin = "";
  bool _isResendButtonEnabled = true;
  bool _aadharError = true;
  int _otpSent = 2;
  bool otpNull = false;
  bool aadharGet = false;
  bool aadharExist = false;
  bool isUpdateDetails = false;
  String otpSentMobileNo = '';
  late Timer _resendTimer;
  Duration _remainingTime = const Duration(minutes: 2);

  @override
  void initState() {
    super.initState();
    _resendTimer = Timer(Duration.zero, () {});
  }

  @override
  void dispose() {
    _resendTimer.cancel();
    _phoneTextFieldController.dispose();
    _aadharTextFieldController.dispose();
    super.dispose();
  }

  void _startResendTimer() {
    setState(() {
      _isResendButtonEnabled = false;
      _remainingTime = const Duration(minutes: 2);
    });
    _resendTimer.cancel();
    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      setState(() {
        if (_remainingTime.inSeconds > 0) {
          _remainingTime -= const Duration(seconds: 1);
        } else {
          _isResendButtonEnabled = true;
          _resendTimer.cancel();
        }
      });
    });
  }

  String _formatTime(Duration duration) {
    String twoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }

    String minutes = twoDigits(duration.inMinutes.remainder(60));
    String seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    print("aadhar    ---------->DataResponse");
    print(context.read<RequestOtpBloc>().state.getData()?.data?.id);
    return IgnorePointer(
      ignoring: context.read<RequestOtpBloc>().state.isLoading() ||
          context.read<RequestOtpBloc>().state.isLoading1() ||
          context.read<AadharDetailsBloc>().state.isLoading(),
      child: Scaffold(
        appBar: CustomImageAppBar(
          showSettings: false,
          showEditIcon: false,
          context: context,
          title: "Add Visitor Details",
        ),
        body: FormBuilder(
          key: context.read<GlobalKey<FormBuilderState>>(),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: sizeHeight(context) / 25,
                  ),
                  Container(
                    width: appSize(context: context, unit: 1.5),
                    decoration: BoxDecoration(
                      color: background_grey_color,
                      border: Border.all(
                          color: Colors.grey.withOpacity(
                        0.3,
                      )),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                      ),
                      child: Center(
                        child: Text(
                          'Indian',
                          style: AppStyle.bodySmall(context)
                              .copyWith(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: sizeHeight(context) / 35,
                  ),
                  BlocProvider(
                    create: (context) => ValidatorOnChanged(),
                    child: BlocConsumer<ValidatorOnChanged, String>(
                      listener: (context, state) {
                        if (state == '') {
                          _aadharError = false;
                        }
                        if (state != '') {
                          _aadharError = true;
                        }
                      },
                      builder: (context, state) {
                        return Column(
                          children: [
                            AddFormField(
                              isRequired: true,
                              controller: _aadharTextFieldController,
                              isEnable: (context
                                              .read<RequestOtpBloc>()
                                              .state
                                              .isLoading() ||
                                          context
                                              .read<RequestOtpBloc>()
                                              .state
                                              .isLoading1()) ||
                                      (aadharExist) ||
                                      context
                                                  .read<RequestOtpBloc>()
                                                  .state
                                                  .getData()
                                                  ?.success ==
                                              true &&
                                          _otpSent == 1
                                  ? false
                                  : true,
                              errorMsg: state,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                  RegExp(r'\d|\s'),
                                ),
                                AadharInputFormatter(inputLength: 12),
                              ],
                              keyboardType: TextInputType.number,
                              hintText: 'Enter Aadhaar No',
                              label: 'Aadhaar No.',
                              onChanged: (aadharNo) {
                                context
                                    .read<ValidatorOnChanged>()
                                    .validateAadhar(aadharNo);
                                if (_otpSent != 2 && aadharNo.length < 14) {
                                  setState(() {
                                    _otpSent = 2;
                                  });
                                }
                              },
                              validator: (value) {
                                if (value?.isEmpty ?? false) {
                                  return 'Please enter Aadhaar No';
                                }
                                if (!RegExp(r'^[2-9][0-9]{3}[0-9]{4}[0-9]{4}$')
                                    .hasMatch(
                                        value?.replaceAll(" ", "") ?? '')) {
                                  return 'Please enter valid Aadhaar No';
                                }
                                return null;
                              },
                            ),
                            RequestOtpBuilder(
                              appError: (v) {
                                if (v) {
                                  setState(() {});
                                }
                              },
                              isUpdateDetails: isUpdateDetails,
                              onGenerateOtpPressed: () {
                                setState(() {
                                  _otpSent = 2;
                                  _phoneTextFieldController.clear();
                                });
                                context
                                    .read<ValidatorOnChanged>()
                                    .validateAadhar(_aadharTextFieldController
                                        .text
                                        .replaceAll(' ', ''));
                                if (!_aadharError) {
                                  context.read<RequestOtpBloc>().requestOtp(
                                        isUpdateDetails: false,
                                        aadharNo: _aadharTextFieldController
                                            .text
                                            .replaceAll(' ', ''),
                                      );
                                }
                              },
                              onSuccess: () {
                                setState(() {
                                  isUpdateDetails = false;
                                  _otpSent = context
                                              .read<RequestOtpBloc>()
                                              .state
                                              .getData()
                                              ?.isOtp ==
                                          1
                                      ? 1
                                      : 0;
                                  if (otpSentMobileNo == '') {
                                    otpSentMobileNo = context
                                            .read<RequestOtpBloc>()
                                            .state
                                            .getData()
                                            ?.data
                                            ?.lastDigits ??
                                        '';
                                  }
                                  if (_otpSent == 0) {
                                    _phoneTextFieldController.text = context
                                            .read<RequestOtpBloc>()
                                            .state
                                            .getData()
                                            ?.data
                                            ?.mobileNumber ??
                                        '';
                                  }
                                });
                                _startResendTimer();
                              },
                              aadharerror: (error) {
                                AppActionDialog.showActionDialog(
                                  image: "$icons_path/ErrorIcon.png",
                                  context: context,
                                  title: "Error occurred",
                                  subtitle: error
                                          .toLowerCase()
                                          .contains("exception")
                                      ? "Something went wrong please\ntry again"
                                      : error,
                                  child: DotsProgressButton(
                                    text: "Try Again",
                                    isRectangularBorder: true,
                                    buttonBackgroundColor:
                                        const Color(0xffF04646),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                  showLeftSideButton: false,
                                );
                                setState(() {});
                              },
                              disableButton: (context
                                                  .read<RequestOtpBloc>()
                                                  .state
                                                  .getData()
                                                  ?.success ==
                                              true &&
                                          _otpSent == 1) ||
                                      context
                                          .read<RequestOtpBloc>()
                                          .state
                                          .isLoading1() ||
                                      aadharExist
                                  ? true
                                  : false,
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  _otpSent == 1
                      ? Column(
                          children: [
                            SizedBox(
                              height: sizeHeight(context) / 25,
                            ),
                            BlocProvider(
                              create: (context) => ValidatorOnChanged(),
                              child: BlocBuilder<ValidatorOnChanged, String>(
                                builder: (context, state) {
                                  return AddFormField(
                                    isRequired: true,
                                    label: 'Mobile Number',
                                    isMobileNumber: true,
                                    countryCode: '91',
                                    hintText: 'Enter Mobile Number',
                                    errorMsg: state,
                                    maxLength: 10,
                                    isEnable: !context
                                            .read<AadharDetailsBloc>()
                                            .state
                                            .isLoading() &&
                                        !aadharGet &&
                                        !aadharExist,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                        RegExp(r'\d|\s'),
                                      ),
                                    ],
                                    onChanged: (phoneNo) {
                                      context
                                          .read<ValidatorOnChanged>()
                                          .validateMobile(phoneNo, context);
                                      if (RegExp(r'[5-9][0-9]{9}')
                                              .hasMatch(phoneNo) &&
                                          _phoneTextFieldController
                                                  .text.length ==
                                              10) {
                                        FocusScope.of(context).unfocus();
                                      }
                                      FormErrorBuilder
                                          .validateFormAndShowErrors(context);
                                    },
                                    keyboardType: TextInputType.number,
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
                                  );
                                },
                              ),
                            ),
                            SizedBox(
                              height: sizeHeight(context) / 50,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    style: AppStyle.bodyMedium(context)
                                        .copyWith(fontWeight: FontWeight.w500),
                                    children: [
                                      TextSpan(
                                        text:
                                            'One time password (OTP) has been sent to mobile number ending with $otpSentMobileNo  ',
                                      ),
                                      WidgetSpan(
                                        child: GestureDetector(
                                          onTap: () {
                                            if (!context
                                                .read<AadharDetailsBloc>()
                                                .state
                                                .isLoading()) {
                                              setState(() {
                                                _otpSent = 2;
                                                otpSentMobileNo = '';
                                                _phoneTextFieldController
                                                    .clear();
                                                aadharExist = false;
                                                currentPin = '';
                                                _resendTimer.cancel();
                                                isUpdateDetails = false;
                                              });
                                            }
                                          },
                                          child: Text(
                                            'Change',
                                            style: AppStyle.bodyMedium(context)
                                                .copyWith(
                                              fontWeight: FontWeight.w500,
                                              color: !context
                                                      .read<AadharDetailsBloc>()
                                                      .state
                                                      .isLoading()
                                                  ? const Color.fromRGBO(
                                                      9, 120, 187, 1)
                                                  : gray_color,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: sizeHeight(context) / 30,
                                ),
                                const FormFieldLabel(
                                  isRequired: true,
                                  label: 'Enter OTP',
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                PinCodeTextField(
                                  key: pinCodeKey,
                                  appContext: context,
                                  length: 6,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  animationType: AnimationType.none,
                                  cursorColor: Colors.black,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'[0-9]')),
                                  ],
                                  textStyle: AppStyle.bodySmall(context)
                                      .copyWith(
                                          color: !context
                                                      .read<AadharDetailsBloc>()
                                                      .state
                                                      .isLoading() &&
                                                  !aadharGet
                                              ? text_color
                                              : gray_color,
                                          fontWeight: FontWeight.w400),
                                  pinTheme: PinTheme(
                                      shape: PinCodeFieldShape.box,
                                      borderRadius: BorderRadius.circular(5),
                                      fieldHeight: sizeHeight(context) / 16,
                                      fieldWidth: sizeWidth(context) / 8,
                                      activeFillColor: textFeildFillColor,
                                      inactiveFillColor: textFeildFillColor,
                                      selectedFillColor: textFeildFillColor,
                                      activeColor: Colors.grey.withOpacity(0.2),
                                      inactiveColor:
                                          Colors.grey.withOpacity(0.2),
                                      selectedColor:
                                          Colors.grey.withOpacity(0.2),
                                      disabledColor:
                                          Colors.grey.withOpacity(0.1),
                                      borderWidth: 1,
                                      activeBorderWidth: 1,
                                      inactiveBorderWidth: 1,
                                      selectedBorderWidth: 1,
                                      disabledBorderWidth: 1),
                                  backgroundColor: Colors.transparent,
                                  enableActiveFill: true,
                                  enabled: !context
                                          .read<AadharDetailsBloc>()
                                          .state
                                          .isLoading() &&
                                      !aadharGet,
                                  onChanged: (String value) {
                                    setState(() {
                                      currentPin = value;
                                    });
                                  },
                                  onCompleted: (String verificationCode) {
                                    setState(() {
                                      currentPin = verificationCode;
                                      otpNull = false;
                                    });
                                  },
                                  controller:
                                      TextEditingController(text: currentPin),
                                ),
                                if (otpNull)
                                  Padding(
                                    padding: const EdgeInsets.only(left: 12.0),
                                    child: Text(
                                      currentPin == ''
                                          ? "Please enter otp"
                                          : "Please enter valid otp",
                                      style: AppStyle.errorStyle(context),
                                    ),
                                  )
                              ],
                            ),
                            if (!aadharGet)
                              SizedBox(
                                height: sizeHeight(context) / 30,
                              ),
                            if (!aadharGet)
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  context
                                          .read<RequestOtpBloc>()
                                          .state
                                          .isLoading1()
                                      ? const LoadingWidget()
                                      : GestureDetector(
                                          onTap: () {
                                            if (!context
                                                .read<AadharDetailsBloc>()
                                                .state
                                                .isLoading()) {
                                              if (_isResendButtonEnabled) {
                                                if (!aadharExist) {
                                                  setState(() {
                                                    isUpdateDetails = true;
                                                    currentPin = '';
                                                    pinCodeKey = UniqueKey();
                                                  });
                                                  context
                                                      .read<RequestOtpBloc>()
                                                      .requestOtp(
                                                        isUpdateDetails: true,
                                                        aadharNo:
                                                            _aadharTextFieldController
                                                                .text
                                                                .replaceAll(
                                                                    ' ', ''),
                                                      );
                                                } else {
                                                  setState(() {
                                                    currentPin = '';
                                                    pinCodeKey = UniqueKey();
                                                  });
                                                  String mobileNumber = context
                                                          .read<
                                                              RequestOtpBloc>()
                                                          .state
                                                          .getData()
                                                          ?.data
                                                          ?.mobileNumber ??
                                                      '';
                                                  otpSentMobileNo = mobileNumber
                                                              .length >=
                                                          3
                                                      ? mobileNumber.substring(
                                                          mobileNumber.length -
                                                              3)
                                                      : mobileNumber;
                                                  context
                                                      .read<RequestOtpBloc>()
                                                      .requestOtp(
                                                        isUpdateDetails: true,
                                                        update: 1,
                                                        id: context
                                                                .read<
                                                                    RequestOtpBloc>()
                                                                .state
                                                                .getData()
                                                                ?.data
                                                                ?.id ??
                                                            0,
                                                        mobileNo:
                                                            _phoneTextFieldController
                                                                .text,
                                                        aadharNo:
                                                            _aadharTextFieldController
                                                                .text
                                                                .replaceAll(
                                                                    ' ', ''),
                                                      );
                                                }
                                              } else {
                                                ToastUtils().showToast(
                                                  context,
                                                  message: 'OTP already Sent',
                                                  toastStatus:
                                                      ToastStatus.invalid,
                                                );
                                              }
                                            }
                                          },
                                          child: Text(
                                            'Resend OTP',
                                            style: AppStyle.bodyMedium(context)
                                                .copyWith(
                                                    color: !context
                                                                .read<
                                                                    AadharDetailsBloc>()
                                                                .state
                                                                .isLoading() &&
                                                            _isResendButtonEnabled
                                                        ? primary_color
                                                        : gray_color),
                                          ),
                                        ),
                                  if (!_isResendButtonEnabled)
                                    Text(
                                      ' in ${_formatTime(_remainingTime)}',
                                      style: AppStyle.bodyMedium(context)
                                          .copyWith(
                                              fontWeight: FontWeight.w600),
                                    )
                                ],
                              ),
                            SizedBox(
                              height: sizeHeight(context) / 30,
                            ),
                            OtpVerificationBuilder(
                              appError: (v) {
                                if (v) {
                                  setState(() {});
                                }
                              },
                              onError: (error) {
                                AppActionDialog.showActionDialog(
                                  image: "$icons_path/ErrorIcon.png",
                                  context: context,
                                  title: "Error occurred",
                                  subtitle: error
                                          .toLowerCase()
                                          .contains("exception")
                                      ? "Something went wrong please\ntry again"
                                      : error,
                                  child: DotsProgressButton(
                                    text: "Try Again",
                                    isRectangularBorder: true,
                                    buttonBackgroundColor:
                                        const Color(0xffF04646),
                                    onPressed: () {
                                      Navigator.pop(context);
                                      setState(() {
                                        currentPin = '';
                                        pinCodeKey = UniqueKey();
                                      });
                                    },
                                  ),
                                  showLeftSideButton: false,
                                );
                              },
                              onWrongOtp: () {
                                if (context
                                        .read<AadharDetailsBloc>()
                                        .state
                                        .getData()
                                        ?.success ==
                                    false) {
                                  currentPin = '';
                                  pinCodeKey = UniqueKey();
                                } else {}
                                setState(() {});
                              },
                              onVerifyOtpPressed: () {
                                if (currentPin == '' || currentPin.length < 6) {
                                  otpNull = true;
                                } else {
                                  otpNull = false;
                                }
                                setState(() {});
                                if (FormErrorBuilder.validateFormAndShowErrors(
                                        context) &&
                                    !otpNull) {
                                  _isResendButtonEnabled = true;
                                  _resendTimer.cancel();
                                  context
                                      .read<AadharDetailsBloc>()
                                      .getAadharDetails(
                                          mobileNo:
                                              _phoneTextFieldController.text,
                                          aadharNo: _aadharTextFieldController
                                              .text
                                              .replaceAll(' ', ''),
                                          update: 1,
                                          id: context
                                                  .read<RequestOtpBloc>()
                                                  .state
                                                  .getData()
                                                  ?.data
                                                  ?.id ??
                                              0,
                                          otp: currentPin);
                                }
                              },
                              onSuccess: () {
                                if (context
                                        .read<AadharDetailsBloc>()
                                        .state
                                        .getData()
                                        ?.status ==
                                    200) {
                                  setState(() {
                                    _isResendButtonEnabled = false;
                                    _resendTimer.cancel();
                                    aadharGet = true;
                                  });
                                  Navigator.of(context).pushReplacement(
                                    goToRoute(
                                      AddVisitorDetails(
                                        aadharDataResponse: context
                                            .read<AadharDetailsBloc>()
                                            .state
                                            .getData()
                                            ?.data
                                            ?.aadharDataResponse,
                                      ),
                                    ),
                                  );
                                }
                              },
                            ),
                            SizedBox(
                              height: sizeHeight(context) / 20,
                            ),
                          ],
                        )
                      : _otpSent == 0 &&
                              !context
                                  .read<AadharDetailsBloc>()
                                  .state
                                  .isLoading() &&
                              !context.read<RequestOtpBloc>().state.isError()
                          ? Column(
                              children: [
                                AadharDetails(
                                  aadharDataResponse: context
                                      .read<RequestOtpBloc>()
                                      .state
                                      .getData()
                                      ?.data
                                      ?.aadharDataResponse,
                                ),
                                const SizedBox(
                                  height: 14,
                                ),
                                ResendOtpBuilder(
                                  appError: (v) {
                                    if (v) {
                                      setState(() {});
                                    }
                                  },
                                  buttonName: 'Update Details',
                                  onSuccess: () {
                                    setState(() {
                                      currentPin = '';
                                    });
                                  },
                                  onGenerateOtpPressed: () {
                                    print("generate addhar otp");
                                    print(context
                                        .read<RequestOtpBloc>()
                                        .state
                                        .getData()
                                        ?.data
                                        ?.id);
                                    aadharExist = true;
                                    String mobileNumber = context
                                            .read<RequestOtpBloc>()
                                            .state
                                            .getData()
                                            ?.data
                                            ?.mobileNumber ??
                                        '';
                                    otpSentMobileNo = mobileNumber.length >= 3
                                        ? mobileNumber
                                            .substring(mobileNumber.length - 3)
                                        : mobileNumber;
                                    context.read<RequestOtpBloc>().requestOtp(
                                          isUpdateDetails: true,
                                          update: 1,
                                          id: context
                                                  .read<RequestOtpBloc>()
                                                  .state
                                                  .getData()
                                                  ?.data
                                                  ?.id ??
                                              0,
                                          mobileNo:
                                              _phoneTextFieldController.text,
                                          aadharNo: _aadharTextFieldController
                                              .text
                                              .replaceAll(' ', ''),
                                        );
                                  },
                                )
                              ],
                            )
                          : Container(),
                ],
              ),
            ),
          ),
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
