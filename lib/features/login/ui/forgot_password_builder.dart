import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/common/blocs/state_events/ui_state.dart';
import 'package:host_visitor_connect/common/custom_widget/app_action_dilog.dart';
import 'package:host_visitor_connect/common/custom_widget/dots_progress_button.dart';
import 'package:host_visitor_connect/common/res/colors.dart';
import 'package:host_visitor_connect/common/res/paths.dart';
import 'package:host_visitor_connect/features/login/blocs/forgot_password_bloc.dart';

class ForgotPasswordBuilder extends StatelessWidget {
  final Function() onChanged;

  const ForgotPasswordBuilder({
    Key? key,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: context.read<ForgotPasswordBloc>(),
      listener: (context, UiState state) async {
        if (state is Success) {
          if ((context.read<ForgotPasswordBloc>().state.getData()?.success ?? false) &&
              (context.read<ForgotPasswordBloc>().state.getData()?.status == 200)) {
            AppActionDialog.showActionDialog(
              image: "$icons_path/confirm.png",
              context: context,
              title: "Success",
              success: true,
              subtitle: "Password has been sent successfully\non your Mobile Number",
              child: DotsProgressButton(
                text: "Done",
                isRectangularBorder: true,
                buttonBackgroundColor: Colors.green.shade400,
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
              ),
              showLeftSideButton: false,
            );
          } else {
            AppActionDialog.showActionDialog(
              image: "$icons_path/ErrorIcon.png",
              context: context,
              title: "Error occurred",
              subtitle:
                  context.read<ForgotPasswordBloc>().state.getData()?.message ?? "Invalid Password",
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
        } else if (state is Error) {
          AppActionDialog.showActionDialog(
            image: "$icons_path/ErrorIcon.png",
            context: context,
            title: "Error occurred",
            subtitle: context.read<ForgotPasswordBloc>().state.getData()?.message ??
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
            text: 'Send Password',
            isProgress: true,
            isRectangularBorder: true,
            buttonBackgroundColor: profileTextColor,
          );
        }
        return DotsProgressButton(
          isRectangularBorder: true,
          text: 'Send Password',
          isProgress: false,
          onPressed: onChanged,
          buttonBackgroundColor: profileTextColor,
        );
      },
    );
  }
}
