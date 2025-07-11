import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/common/blocs/state_events/ui_state.dart';
import 'package:host_visitor_connect/common/custom_widget/app_action_dilog.dart';
import 'package:host_visitor_connect/common/custom_widget/button.dart';
import 'package:host_visitor_connect/common/custom_widget/dots_progress_button.dart';
import 'package:host_visitor_connect/common/custom_widget/initializer.dart';
import 'package:host_visitor_connect/common/res/colors.dart';
import 'package:host_visitor_connect/common/res/keys.dart';
import 'package:host_visitor_connect/common/res/paths.dart';
import 'package:host_visitor_connect/common/res/styles.dart';
import 'package:host_visitor_connect/common/shared_prefs.dart';
import 'package:host_visitor_connect/common/utils/route_generator.dart';
import 'package:host_visitor_connect/features/dashboard/bloc/user_details_bloc.dart';
import 'package:host_visitor_connect/features/dashboard/ui/home_page.dart';
import 'package:host_visitor_connect/features/login/blocs/login_with_password_bloc.dart';
import 'package:provider/provider.dart';

class LoginBranchBuilder extends StatelessWidget {
  final Function()? onSuccess;
  final Function()? onLoginPressed;
  final String? password;
  final String? phoneNo;
  final int? hostId;

  const LoginBranchBuilder({
    Key? key,
    this.onSuccess,
    this.onLoginPressed,
    this.password,
    this.phoneNo,
    this.hostId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: context.read<LoginWithPasswordBloc>(),
      listener: (context, UiState state) {
        if (state is Success) {
          if (context.read<LoginWithPasswordBloc>().state.getData()?.status ==
              200) {
            onSuccess?.call();
          } else {
            if (context
                    .read<LoginWithPasswordBloc>()
                    .state
                    .getData()
                    ?.logoutReason ==
                2) {
              final sessionId = context
                  .read<LoginWithPasswordBloc>()
                  .state
                  .getData()
                  ?.reLoginId;

              showDialog(
                context: context,
                barrierDismissible: true,
                builder: (_) {
                  return MultiProvider(
                    providers: [
                      BlocProvider.value(
                        value: context.read<LoginWithPasswordBloc>(),
                      ),
                    ],
                    child: DialogBoxforAadharAndVoter(
                      heading: 'Re-Login',
                      confirmationText:
                          'Your id is Logged into another device, are you sure you want to login here? \n\nYou will get logged out from another device.',
                      child: LoginBranchBuilder(
                        onLoginPressed: () {
                          int branchId = SharedPrefs.getInt(keyBranch) ?? 0;

                          print(branchId);

                          /// todo  uncomment when demo is oveer

                          // Validation check
                          // if (branchId == 0) {
                          //   AppActionDialog.showActionDialog(
                          //     image: "$icons_path/ErrorIcon.png",
                          //     context: context,
                          //     title: "No Nearby Branch",
                          //     subtitle:
                          //         "No nearby branches were found. Please check your location and try again.",
                          //     child: DotsProgressButton(
                          //       text: "Ok",
                          //       isRectangularBorder: true,
                          //       buttonBackgroundColor: const Color(0xffF04646),
                          //       onPressed: () {
                          //         Navigator.pop(context);
                          //       },
                          //     ),
                          //     showLeftSideButton: false,
                          //   );
                          //   return;
                          // }

                          context
                              .read<LoginWithPasswordBloc>()
                              .loginWithPassword(
                                hostId: hostId,
                                phoneNo: phoneNo ?? '',
                                branchId: branchId,
                                password: password ?? '',
                                reLoginId: sessionId ?? 0,
                              );
                        },
                        onSuccess: () async {
                          await context.read<UserDetailsBloc>().userDetails();
                          Navigator.pushAndRemoveUntil(
                            context,
                            goToRoute(const HomePage(isFirst: true)),
                            (route) {
                              return false;
                            },
                          );
                          return;
                        },
                      ),
                    ),
                  );
                },
              );
            } else {
              AppActionDialog.showActionDialog(
                color: Colors.yellow,
                showOrangeCOlor: true,
                image: "$icons_path/warning.png",
                context: context,
                title: context
                            .read<LoginWithPasswordBloc>()
                            .state
                            .getData()
                            ?.status ==
                        422
                    ? 'Incorrect Password'
                    : "Error occurred",
                subtitle: context
                        .read<LoginWithPasswordBloc>()
                        .state
                        .getData()
                        ?.message ??
                    "Something went wrong, please try again.",
                child: DotsProgressButton(
                  text: "Try Again",
                  isRectangularBorder: true,
                  buttonBackgroundColor: Colors.amber,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                showLeftSideButton: false,
              );
            }
          }
        } else if (state is Error) {
          AppActionDialog.showActionDialog(
            image: "$icons_path/ErrorIcon.png",
            context: context,
            title: "Error occurred",
            subtitle: context
                    .read<LoginWithPasswordBloc>()
                    .state
                    .getData()
                    ?.message ??
                "Something went wrong, please try again.",
            child: DotsProgressButton(
              text: "Try Again",
              isRectangularBorder: true,
              buttonBackgroundColor: const Color(0xffF04646),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            showLeftSideButton: false,
          );
        }
      },
      builder: (_, UiState state) {
        if (state is Progress) {
          return const DotsProgressButton(
            isRectangularBorder: true,
            text: 'Login',
            isProgress: true,
            buttonBackgroundColor: profileTextColor,
          );
        }
        return DotsProgressButton(
          isRectangularBorder: true,
          text: 'Login',
          isProgress: false,
          onPressed: () {
            int branchId = SharedPrefs.getInt(keyBranch) ?? 0;

            print(branchId);

            /// todo  uncomment when demo is oveer

            // Validation check
            // if (branchId == 0) {
            //   AppActionDialog.showActionDialog(
            //     image: "$icons_path/ErrorIcon.png",
            //     context: context,
            //     title: "No Nearby Branch",
            //     subtitle:
            //         "You're not near to any branch. Please check your location and try again.",
            //     child: DotsProgressButton(
            //       text: "Ok",
            //       isRectangularBorder: true,
            //       buttonBackgroundColor: const Color(0xffF04646),
            //       onPressed: () {
            //         Navigator.pop(context);
            //       },
            //     ),
            //     showLeftSideButton: false,
            //   );
            //   return;
            // }

            onLoginPressed?.call();
          },
          buttonBackgroundColor: profileTextColor,
        );
      },
    );
  }
}

class DialogBoxforAadharAndVoter extends StatelessWidget {
  final bool? isProgress;
  final String? heading;
  final String? confirmationText;
  final Function()? onYesPressed;
  final Widget child;
  final String? password;
  final String? phoneNo;

  const DialogBoxforAadharAndVoter({
    Key? key,
    this.heading,
    this.confirmationText,
    this.onYesPressed,
    required this.child,
    this.isProgress,
    this.password,
    this.phoneNo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return context.read<LoginWithPasswordBloc>().state is Progress;
      },
      child: _DialogBox(
        headerTitle: heading ?? '',
        bodyContent: IgnorePointer(
          ignoring: context.watch<LoginWithPasswordBloc>().state is Progress,
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  confirmationText ?? '',
                  style:
                      AppStyle.bodyLarge(context).copyWith(color: text_color),
                ),

                // White space
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  height: appSize(context: context, unit: 10) / 5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Initializer(child: child),
                      const SizedBox(
                        width: 12,
                      ),
                      IgnorePointer(
                        ignoring: context.watch<LoginWithPasswordBloc>().state
                            is Progress,
                        child: Button(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 45,
                          ),
                          text: 'No',
                          isRectangularBorder: true,
                          backgroundColor: disabled_color,
                          onPressed: () {
                            Navigator.pop(context); // Close the dialog
                          },
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DialogBox extends StatelessWidget {
  final Widget bodyContent;
  final String headerTitle;

  const _DialogBox({
    Key? key,
    required this.bodyContent,
    required this.headerTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 60,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //..
          _DialogHeader(
            title: headerTitle,
          ),

          // Dialog Body
          Flexible(
            child: _DialogBody(
              content: bodyContent,
            ),
          )
        ],
      ),
    );
  }
}

class _DialogHeader extends StatelessWidget {
  final String title;

  const _DialogHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFEBEDF3),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(5),
          topRight: Radius.circular(5),
        ),
      ),

      //..
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Text(
              title,
              style: AppStyle.bodyLarge(context)
                  .copyWith(fontWeight: FontWeight.w500),
            ),
          ),

          const Spacer(),

          //..
          IgnorePointer(
            ignoring: context.watch<LoginWithPasswordBloc>().state is Progress,
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.close),
            ),
          ),
        ],
      ),
    );
  }
}

class _DialogBody extends StatelessWidget {
  final Widget content;

  const _DialogBody({
    Key? key,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(5),
          bottomRight: Radius.circular(5),
        ),
      ),
      child: SingleChildScrollView(
        child: content,
      ),
    );
  }
}
