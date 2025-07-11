import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/common/app_toast.dart';
import 'package:host_visitor_connect/common/blocs/state_events/ui_state.dart';
import 'package:host_visitor_connect/common/custom_widget/dots_progress_button.dart';
import 'package:host_visitor_connect/common/utils/common_error_handler.dart';
import 'package:host_visitor_connect/common/utils/toast_utils.dart';
import 'package:host_visitor_connect/features/visitors/visitor_listing/blocs/check_out_bloc.dart';

class CheckOutVisitorBuilder extends StatelessWidget {
  final Function()? onSuccess;
  final Function()? onCheckOutPressed;
  final Function(String errorMsg)? error;

  const CheckOutVisitorBuilder(
      {Key? key, this.onSuccess, this.onCheckOutPressed, this.error})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: context.read<CheckOutBloc>(),
      listener: (context, UiState state) {
        if (state is Success) {
          if (context.read<CheckOutBloc>().state.getData()?.success ?? false) {
            onSuccess?.call();
          } else {
            ToastUtils().showToast(
              context,
              message: context.read<CheckOutBloc>().state.getData()?.message ??
                  'Invalid',
              toastStatus: ToastStatus.invalid,
            );
          }
        } else if (state is Error) {
          CommonErrorHandler(
            context,
            exception: state.exception,
          ).showToast();
        }
      },
      builder: (_, UiState state) {
        if (state is Progress) {
          return const DotsProgressButton(
            isRectangularBorder: true,
            text: 'Yes',
            isProgress: true,
          );
        }
        return DotsProgressButton(
          isRectangularBorder: true,
          text: 'Yes',
          isProgress: false,
          onPressed: onCheckOutPressed,
        );
      },
    );
  }
}
