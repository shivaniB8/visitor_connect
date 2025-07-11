import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:host_visitor_connect/common/custom_widget/app_bar_widget/custom_widget_image_app_bar.dart';
import 'package:host_visitor_connect/common/custom_widget/dots_progress_button.dart';
import 'package:host_visitor_connect/common/custom_widget/fields/add_form_field.dart';
import 'package:host_visitor_connect/common/custom_widget/fields/form_error.dart';
import 'package:host_visitor_connect/common/res/styles.dart';
import 'package:host_visitor_connect/features/dashboard/bloc/reset_password_bloc.dart';
import 'package:host_visitor_connect/features/profile/ui/reset_password_builder.dart';

class ResetPasswordScreen extends StatefulWidget {
  final bool? isHome;
  const ResetPasswordScreen({
    super.key,
    this.isHome,
  });

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  String? currentPassword;
  String? newPassword;
  String? confirmPassword;
  String? errorMsg;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          widget.isHome ?? false ? Colors.transparent : Colors.white,
      appBar: widget.isHome ?? false
          ? null
          : CustomImageAppBar(
              title: "Change Password",
              showEditIcon: false,
              showSettings: false,
              context: context,
            ),
      body: Column(
        mainAxisSize:
            widget.isHome ?? false ? MainAxisSize.max : MainAxisSize.min,
        mainAxisAlignment: widget.isHome ?? false
            ? MainAxisAlignment.center
            : MainAxisAlignment.start,
        children: [
          if (!(widget.isHome ?? false))
            SizedBox(
              height: 15.h,
            ),
          if (widget.isHome ?? false)
            Container(
              decoration: const BoxDecoration(
                color: Color(0xFFEBEDF3),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),

              //..
              child: Padding(
                padding: const EdgeInsets.all(15),

                //..
                child: Row(
                  children: [
                    const SizedBox(
                      width: 8,
                    ),

                    Text(
                      widget.isHome ?? false
                          ? 'Set Password'
                          : 'Change Password',
                      style: AppStyle.bodyLarge(context)
                          .copyWith(fontWeight: FontWeight.w500),
                    ),

                    const Spacer(),

                    //..
                    widget.isHome ?? false
                        ? const SizedBox()
                        : InkWell(
                            onTap: () => Navigator.pop(context),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(Icons.close),
                            ),
                          ),
                  ],
                ),
              ),
            ),
          Flexible(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15.0,
                  vertical: 10,
                ),
                child: SingleChildScrollView(
                  child: FormBuilder(
                    key: context.read<GlobalKey<FormBuilderState>>(),
                    child: Column(
                      children: [
                        AddFormField(
                          maxLines: 1,
                          label: 'Current Password',
                          hintText: 'Enter your current password',
                          onChanged: (currentPas) {
                            currentPassword = currentPas;
                          },
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        AddFormField(
                          maxLines: 1,
                          label: 'New Password',
                          hintText: 'Enter new password',
                          onChanged: (newPass) {
                            newPassword = newPass;
                          },
                          validator: (newPass) {
                            if ((newPass?.isEmpty ?? false) ||
                                (newPass == null)) {
                              return 'Please enter new password';
                            } else if (!RegExp(
                                    r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                                .hasMatch(newPass)) {
                              return 'Password is not strong';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        AddFormField(
                          maxLines: 1,
                          label: 'Confirm Password',
                          hintText: 'Enter confirm password',
                          onChanged: (confirmPass) {
                            confirmPassword = confirmPass;
                          },
                          validator: (password) {
                            if ((password?.isEmpty ?? false) ||
                                (password == null)) {
                              return 'Please enter confirm password';
                            } else if (newPassword != password) {
                              return 'Password does not match';
                            } else if (!RegExp(
                                    r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                                .hasMatch(password)) {
                              return 'Password is not strong';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: ResetPasswordBuilder(
                                onSuccess: () {
                                  Navigator.pop(context);
                                },
                                onResetPressed: () {
                                  if (FormErrorBuilder
                                      .validateFormAndShowErrors(context)) {
                                    context
                                        .read<ResetPasswordBloc>()
                                        .resetPassword(
                                          newPassword: newPassword ?? '',
                                          confirmPassword:
                                              confirmPassword ?? '',
                                          oldPassword: currentPassword ?? '',
                                        );
                                  }
                                },
                                onError: (error) {
                                  setState(() {
                                    errorMsg = error;
                                  });
                                },
                              ),
                            ),
                            SizedBox(
                              width: (widget.isHome ?? false) ? 0 : 20.w,
                            ),
                            if (!(widget.isHome ?? false))
                              Expanded(
                                child: DotsProgressButton(
                                  isRectangularBorder: true,
                                  text: 'Cancel',
                                  buttonBackgroundColor: Colors.grey,
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              )
                          ],
                        ),
                        if (context
                                .read<ResetPasswordBloc>()
                                .state
                                .getData()
                                ?.success ==
                            false)
                          SizedBox(
                            height: 8.h,
                          ),
                        if (context
                                .read<ResetPasswordBloc>()
                                .state
                                .getData()
                                ?.success ==
                            false)
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical:
                                    appSize(context: context, unit: 10) / 20),
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
                                style: AppStyle.errorStyle(context),
                              ),
                            ),
                          ),
                        SizedBox(
                          height: 8.h,
                        ),
                      ],
                    ),
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
