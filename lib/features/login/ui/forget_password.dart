import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:host_visitor_connect/common/blocs/validator_bloc.dart';
import 'package:host_visitor_connect/common/custom_widget/fields/add_form_field.dart';
import 'package:host_visitor_connect/common/custom_widget/fields/form_error.dart';
import 'package:host_visitor_connect/common/extensions/string_extensions.dart';
import 'package:host_visitor_connect/common/res/colors.dart';
import 'package:host_visitor_connect/common/res/paths.dart';
import 'package:host_visitor_connect/common/res/styles.dart';
import 'package:host_visitor_connect/common/utils/utils.dart';
import 'package:host_visitor_connect/features/login/blocs/forgot_password_bloc.dart';
import 'package:host_visitor_connect/features/login/ui/forgot_password_builder.dart';
import 'package:host_visitor_connect/generated/l10n.dart';
import 'package:host_visitor_connect/landingScreen/Widget/background.dart';
import 'package:host_visitor_connect/landingScreen/Widget/footerImage.dart';
import 'package:host_visitor_connect/landingScreen/Widget/headerImage.dart';

class ForgetPassword extends StatefulWidget {
  final String? phoneNumber;
  final bool? isEnable;
  const ForgetPassword({
    this.phoneNumber,
    this.isEnable,
    super.key,
  });

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  late TextEditingController _passwordTextFieldController;
  // String mobileNo = '';

  @override
  void initState() {
    _passwordTextFieldController = TextEditingController(text: widget.phoneNumber);
    super.initState();
  }

  @override
  void dispose() {
    _passwordTextFieldController.dispose();
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
            margin: EdgeInsets.only(top: sizeHeight(context) / 12),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(28), topRight: Radius.circular(28)),
              child: Scaffold(
                backgroundColor: text_color.withOpacity(0.4),
                body: Stack(
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: sizeHeight(context) / 100,
                          ),
                          const HeaderImage(),
                          // SizedBox(
                          //   height: sizeHeight(context) / 20,
                          // ),

                          SizedBox(
                            height: sizeHeight(context) / 10,
                          ),
                          padding(
                            Text(
                              S.of(context).forgotPasswordScreen_label_forgotPasswordSendPassword,
                              style:
                                  AppStyle.titleSmall(context).copyWith(color: primary_text_color),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          padding(
                            FormBuilder(
                              key: context.read<GlobalKey<FormBuilderState>>(),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  BlocProvider(
                                    create: (_) => ValidatorOnChanged(),
                                    child: BlocBuilder<ValidatorOnChanged, String>(
                                        builder: (context, state) {
                                      return AddFormField(
                                        isEnable: widget.isEnable ?? true,
                                        maxLines: 1,
                                        onlyLoginPage: true,
                                        errorMsg: state,
                                        hintText: _passwordTextFieldController.text.isNullOrEmpty()
                                            ? "Enter Phone Number"
                                            : "",
                                        label: '',
                                        cursorColor: primary_text_color,
                                        controller: _passwordTextFieldController,
                                        keyboardType: TextInputType.phone,
                                        maxLength: 10,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.digitsOnly,
                                        ],
                                        onChanged: (phoneNo) {
                                          context
                                              .read<ValidatorOnChanged>()
                                              .validateLoginMobile(phoneNo);
                                        },
                                        validator: (value) {
                                          if (value?.isEmpty ?? false) {
                                            return S
                                                .of(context)
                                                .mobileNoValidation_label_pleaseEnterMobileNumber;
                                          }
                                          if ((value?.startsWith('0') ?? false) &&
                                              !RegExp(r'0[5-9][0-9]{9}').hasMatch(value ?? '')) {
                                            return S
                                                .of(context)
                                                .mobileNoValidation_label_pleaseEnterValidMobileNumber;
                                          } else if (!RegExp(r'[5-9][0-9]{9}')
                                              .hasMatch(value ?? '')) {
                                            return S
                                                .of(context)
                                                .mobileNoValidation_label_pleaseEnterValidMobileNumber;
                                          }
                                          return null;
                                        },
                                      );
                                    }),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: sizeHeight(context) / 30,
                          ),
                          padding(
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: ForgotPasswordBuilder(
                                onChanged: () {
                                  if (FormErrorBuilder.validateFormAndShowErrors(context)) {
                                    FocusScope.of(context).unfocus();
                                    _passwordTextFieldController.text;
                                    context.read<ForgotPasswordBloc>().forgotPassword(
                                          phoneNo: _passwordTextFieldController.text,
                                        );
                                  }
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: sizeHeight(context) / 50,
                          ),
                          IconButton(
                            highlightColor: primary_text_color.withOpacity(0.4),
                            hoverColor: primary_text_color.withOpacity(0.4),
                            onPressed: () => Navigator.pop(context),
                            icon: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.arrow_back_ios,
                                  color: primary_text_color,
                                  size: 20,
                                ),
                                Text(
                                  "Go Back",
                                  style: AppStyle.bodyMedium(context).copyWith(
                                      fontWeight: FontWeight.w600, color: primary_text_color),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (MediaQuery.of(context).viewInsets.bottom == 0)
                      const Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 0, left: 25, right: 25),
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

  Padding padding(Widget child) {
    return Padding(padding: const EdgeInsets.symmetric(horizontal: 20), child: child);
  }
}
