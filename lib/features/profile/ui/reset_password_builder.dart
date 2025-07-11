import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/common/blocs/state_events/ui_state.dart';
import 'package:host_visitor_connect/common/custom_widget/app_action_dilog.dart';
import 'package:host_visitor_connect/common/custom_widget/dots_progress_button.dart';
import 'package:host_visitor_connect/common/res/paths.dart';
import 'package:host_visitor_connect/features/dashboard/bloc/reset_password_bloc.dart';

class ResetPasswordBuilder extends StatelessWidget {
  final Function()? onSuccess;
  final Function()? onResetPressed;
  final Function(String? error)? onError;

  const ResetPasswordBuilder({
    Key? key,
    this.onSuccess,
    this.onResetPressed,
    this.onError,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: context.read<ResetPasswordBloc>(),
      listener: (context, UiState state) {
        if (state is Success &&
            (context.read<ResetPasswordBloc>().state.getData()?.success ??
                false)) {
          onSuccess?.call();
        } else if (state is Success &&
            (!(context.read<ResetPasswordBloc>().state.getData()?.success ?? false))) {
          AppActionDialog.showActionDialog(
            image: "$icons_path/ErrorIcon.png",
            context: context,
            title: "Error occurred",
            subtitle: context.read<ResetPasswordBloc>().state.getData()?.message ??
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
        if (state is Error) {
          AppActionDialog.showActionDialog(
            image: "$icons_path/ErrorIcon.png",
            context: context,
            title: "Error occurred",
            subtitle: "Something went wrong please\ntry again",
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
            text: 'Submit',
            isProgress: true,
          );
        }
        return DotsProgressButton(
          isRectangularBorder: true,
          text: 'Submit',
          isProgress: false,
          onPressed: onResetPressed,
        );
      },
    );
  }
}
