import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/common/blocs/state_events/ui_state.dart';
import 'package:host_visitor_connect/common/custom_widget/dots_progress_button.dart';
import 'package:host_visitor_connect/common/utils/common_error_handler.dart';
import 'package:host_visitor_connect/features/visitors/add_visitor/bloc/aadhar_details_bloc.dart';

class OtpVerificationBuilder extends StatelessWidget {
  final Function()? onVerifyOtpPressed;
  final Function()? onSuccess;
  final Function()? onWrongOtp;
  final bool? disableButton;

  const OtpVerificationBuilder({
    Key? key,
    this.onVerifyOtpPressed,
    this.onSuccess,
    this.disableButton,
    this.onWrongOtp,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: context.read<AadharDetailsBloc>(),
      listener: (context, UiState state) {
        if (state is Success) {
          if ((context.read<AadharDetailsBloc>().state.getData()?.success ??
                  false) &&
              (context.read<AadharDetailsBloc>().state.getData()?.status ==
                  200)) {
            onSuccess?.call();
          } else if (context
                  .read<AadharDetailsBloc>()
                  .state
                  .getData()
                  ?.status !=
              200) {
            onWrongOtp?.call();
          }
        }
        if (state is Error) {
          CommonErrorHandler(
            context,
            exception: state.exception,
          ).showToast();
        }
      },
      builder: (_, UiState state) {
        if (state is Progress) {
          return const DotsProgressButton(
            disableButton: true,
            isRectangularBorder: true,
            text: 'Verify OTP',
            isProgress: true,
          );
        }
        return DotsProgressButton(
          disableButton: disableButton ?? false,
          isRectangularBorder: true,
          text: 'Verify OTP',
          isProgress: false,
          onPressed: onVerifyOtpPressed,
        );
      },
    );
  }
}
