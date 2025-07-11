import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/common/blocs/state_events/ui_state.dart';
import 'package:host_visitor_connect/common/custom_widget/dots_progress_button.dart';
import 'package:host_visitor_connect/common/utils/common_error_handler.dart';
import 'package:host_visitor_connect/features/visitors/add_visitor/bloc/request_otp_bloc.dart';

class ResendOtpBuilder extends StatelessWidget {
  final Function()? onGenerateOtpPressed;
  final String? buttonName;
  final Function()? onSuccess;
  final Function(String aadharError)? aadharerror;
  final bool? disableButton;
  final Function(bool appError)? appError;

  const ResendOtpBuilder({
    Key? key,
    this.onGenerateOtpPressed,
    this.onSuccess,
    this.aadharerror,
    this.buttonName,
    this.disableButton,
    this.appError,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: context.read<RequestOtpBloc>(),
      listener: (context, UiState state) {
        if (state is Success) {
          if (context.read<RequestOtpBloc>().state.getData()?.success ?? false) {
            onSuccess?.call();
          } else {
            aadharerror?.call(
              context.read<RequestOtpBloc>().state.getData()?.message ?? 'Invalid Aadhar Or Number',
            );
          }
        }
        if (state is Error) {
          appError?.call(true);
          CommonErrorHandler(
            context,
            exception: state.exception,
          ).showToast();
        }
      },
      builder: (_, UiState state) {
        if (state is Progress1) {
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            child: DotsProgressButton(
              disableButton: false,
              isRectangularBorder: true,
              text: buttonName ?? 'Request OTP',
              isProgress: true,
            ),
          );
        }
        return SizedBox(
          width: MediaQuery.of(context).size.width,
          child: DotsProgressButton(
            disableButton: disableButton ?? false,
            isRectangularBorder: true,
            text: buttonName ?? 'Request OTP',
            isProgress: false,
            onPressed: onGenerateOtpPressed,
          ),
        );
      },
    );
  }
}
