import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:host_visitor_connect/common/blocs/state_events/ui_state.dart';
import 'package:host_visitor_connect/common/blocs/validator_bloc.dart';
import 'package:host_visitor_connect/common/custom_widget/fields/add_form_field.dart';
import 'package:host_visitor_connect/common/custom_widget/fields/form_error.dart';
import 'package:host_visitor_connect/common/extensions/string_extensions.dart';
import 'package:host_visitor_connect/common/res/colors.dart';
import 'package:host_visitor_connect/common/res/keys.dart';
import 'package:host_visitor_connect/common/res/paths.dart';
import 'package:host_visitor_connect/common/res/styles.dart';
import 'package:host_visitor_connect/common/shared_prefs.dart';
import 'package:host_visitor_connect/common/utils/route_generator.dart';
import 'package:host_visitor_connect/common/utils/utils.dart';
import 'package:host_visitor_connect/features/login/blocs/user_login_mobile_number_bloc.dart';
import 'package:host_visitor_connect/features/login/ui/forgotPaswordWidget.dart';
import 'package:host_visitor_connect/features/login/ui/image_widget.dart';
import 'package:host_visitor_connect/features/login/ui/login_builder.dart';
import 'package:host_visitor_connect/features/login/ui/model/login_model.dart';
import 'package:host_visitor_connect/features/visitors/visitor_listing/ui/connectivityDialog.dart';
import 'package:host_visitor_connect/generated/l10n.dart';
import 'package:host_visitor_connect/landingScreen/Widget/background.dart';
import 'package:host_visitor_connect/landingScreen/Widget/footerImage.dart';
import 'package:host_visitor_connect/landingScreen/Widget/headerImage.dart';
import 'login_branch_screen.dart';
import 'login_provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    super.key,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController _phoneTextFieldController;

  String? errorMsg = '';

  @override
  void initState() {
    ConnectivityDialog.getConnectivity(context);
    _phoneTextFieldController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    // subscription.cancel();
    _phoneTextFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: text_color.withOpacity(0.1),
      child: Stack(
        children: [
          BackGroundWidget(backgroundColor: text_color.withOpacity(0.4)),
          Container(
            // color: Colors.blue,
            margin: EdgeInsets.only(top: sizeHeight(context) / 12),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(28), topRight: Radius.circular(28)),
              child: Scaffold(
                backgroundColor: text_color.withOpacity(0.5),
                body: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 0),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: sizeHeight(context) / 100,
                            ),
                            const HeaderImage(),
                            const LoginImage(),
                            SizedBox(
                              height: sizeHeight(context) / 30,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    child: Text(
                                      'Log In',
                                      style: AppStyle.headlineLarge(context)
                                          .copyWith(
                                              color: primary_text_color,
                                              fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  FormBuilder(
                                    key: context
                                        .read<GlobalKey<FormBuilderState>>(),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.0,
                                          vertical: sizeHeight(context) / 30),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          BlocProvider(
                                            create: (_) => ValidatorOnChanged(),
                                            child: BlocBuilder<
                                                ValidatorOnChanged, String>(
                                              builder: (context, state) {
                                                return AddFormField(
                                                  keyboardType:
                                                      TextInputType.phone,
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter
                                                        .digitsOnly,
                                                  ],
                                                  onlyLoginPage: true,
                                                  maxLines: 1,
                                                  // countryCode: '91',
                                                  controller:
                                                      _phoneTextFieldController,
                                                  isRequired: true,
                                                  hintText: S
                                                      .of(context)
                                                      .loginPage_label_enterYourMobileNumber,
                                                  // isMobileNumber: true,
                                                  errorMsg: state,
                                                  maxLength:
                                                      _phoneTextFieldController
                                                              .text
                                                              .startsWith('0')
                                                          ? 11
                                                          : 10,
                                                  isEnable: (context
                                                          .watch<
                                                              UserLoginMobileNumberBloc>()
                                                          .state is Progress)
                                                      ? false
                                                      : true,
                                                  onChanged: (phoneNo) {
                                                    SharedPrefs.setString(
                                                        keyDummyPhone, phoneNo);
                                                    context
                                                        .read<
                                                            ValidatorOnChanged>()
                                                        .validateLoginMobile(
                                                            phoneNo);

                                                    if (phoneNo
                                                        .startsWith('0')) {
                                                      if (phoneNo.length ==
                                                          11) {
                                                        final mobileNo = phoneNo
                                                            .substring(1, 11);
                                                        context
                                                            .read<LoginModel>()
                                                            .phoneNo = mobileNo;
                                                      }
                                                    } else {
                                                      context
                                                          .read<LoginModel>()
                                                          .phoneNo = phoneNo;
                                                    }
                                                  },
                                                  validator: (value) {
                                                    if (value?.isEmpty ??
                                                        false) {
                                                      return S
                                                          .of(context)
                                                          .mobileNoValidation_label_pleaseEnterMobileNumber;
                                                    }
                                                    if ((value?.startsWith(
                                                                '0') ??
                                                            false) &&
                                                        !RegExp(r'0[5-9][0-9]{9}')
                                                            .hasMatch(
                                                                value ?? '')) {
                                                      return S
                                                          .of(context)
                                                          .mobileNoValidation_label_pleaseEnterValidMobileNumber;
                                                    } else if (!RegExp(
                                                            r'[5-9][0-9]{9}')
                                                        .hasMatch(
                                                            value ?? '')) {
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
                                          if (!(errorMsg.isNullOrEmpty()) &&
                                              context
                                                      .read<
                                                          UserLoginMobileNumberBloc>()
                                                      .state
                                                      .getData()
                                                      ?.status !=
                                                  200 &&
                                              context
                                                  .read<
                                                      UserLoginMobileNumberBloc>()
                                                  .state is! Progress)
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0, right: 5),
                                              child: Text(
                                                errorMsg ?? '',
                                                style: AppStyle.errorStyle(
                                                    context),
                                              ),
                                            ),
                                          ForgotPasswordWidget(
                                              phoneNumber: context
                                                  .read<LoginModel>()
                                                  .phoneNo),
                                          SizedBox(
                                              height: sizeHeight(context) / 30),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: LoginBuilder(
                                              onLoginPressed: () {
                                                if ((FormErrorBuilder
                                                    .validateFormAndShowErrors(
                                                        context))) {
                                                  context
                                                      .read<
                                                          UserLoginMobileNumberBloc>()
                                                      .loginMobileNumber(
                                                        phoneNo: context
                                                            .read<LoginModel>()
                                                            .phoneNo,
                                                      );
                                                }
                                              },
                                              onSuccess: () async {
                                                SharedPrefs.setString(
                                                  keyMasterBucket,
                                                  context
                                                          .read<
                                                              UserLoginMobileNumberBloc>()
                                                          .state
                                                          .getData()
                                                          ?.masterBucketName ??
                                                      '',
                                                );
                                                // ignore: use_build_context_synchronously
                                                Navigator.push(
                                                  context,
                                                  noSlideRoute(
                                                    LoginProvider(
                                                      child: LoginBranchScreen(
                                                        hostList: context
                                                            .read<
                                                                UserLoginMobileNumberBloc>()
                                                            .state
                                                            .getData()
                                                            ?.data,
                                                        phoneNumber: context
                                                            .read<LoginModel>()
                                                            .phoneNo,
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (MediaQuery.of(context).viewInsets.bottom == 0)
                      const Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding:
                              EdgeInsets.only(bottom: 0, left: 25, right: 25),
                          child: FooterImage(
                            image: "$images_path/goaElectronic1.png",
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
    );
  }
}
