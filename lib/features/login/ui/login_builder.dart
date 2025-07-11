import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/common/blocs/state_events/ui_state.dart';
import 'package:host_visitor_connect/common/custom_widget/app_action_dilog.dart';
import 'package:host_visitor_connect/common/custom_widget/dots_progress_button.dart';
import 'package:host_visitor_connect/common/res/colors.dart';
import 'package:host_visitor_connect/common/res/keys.dart';
import 'package:host_visitor_connect/common/res/paths.dart';
import 'package:host_visitor_connect/common/shared_prefs.dart';
import 'package:host_visitor_connect/features/login/blocs/user_login_mobile_number_bloc.dart';

class LoginBuilder extends StatelessWidget {
  final Function()? onSuccess;
  final Function()? onLoginPressed;

  const LoginBuilder({
    Key? key,
    this.onSuccess,
    this.onLoginPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: context.read<UserLoginMobileNumberBloc>(),
      listener: (context, UiState state) {
        if (state is Success) {
          if (context
                  .read<UserLoginMobileNumberBloc>()
                  .state
                  .getData()
                  ?.status ==
              200) {
            onSuccess?.call();
          } else {
            AppActionDialog.showActionDialog(
              image: "$icons_path/ErrorIcon.png",
              context: context,
              title: "Error occurred",
              subtitle: context
                      .read<UserLoginMobileNumberBloc>()
                      .state
                      .getData()
                      ?.message ??
                  "Something went wrong please\ntry again",
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
        }
        if (state is Error) {
          AppActionDialog.showActionDialog(
            image: "$icons_path/ErrorIcon.png",
            context: context,
            title: "Error occurred",
            subtitle: context
                    .read<UserLoginMobileNumberBloc>()
                    .state
                    .getData()
                    ?.message ??
                "Something went wrong please\ntry again",
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
          onPressed: onLoginPressed,
          buttonBackgroundColor: profileTextColor,
        );
      },
    );
  }
}
