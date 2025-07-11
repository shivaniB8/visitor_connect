import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/common/app_toast.dart';
import 'package:host_visitor_connect/common/blocs/state_events/ui_state.dart';
import 'package:host_visitor_connect/common/custom_widget/dots_progress_button.dart';
import 'package:host_visitor_connect/common/res/styles.dart';
import 'package:host_visitor_connect/common/utils/common_error_handler.dart';
import 'package:host_visitor_connect/common/utils/toast_utils.dart';
import 'package:host_visitor_connect/features/support_ticket/bloc/ticket_communication_bloc.dart';

class TicketCommunicationBuilder extends StatelessWidget {
  final Function()? onSubmitMessage;
  final Function()? onSuccess;

  const TicketCommunicationBuilder({
    Key? key,
    this.onSubmitMessage,
    this.onSuccess,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: context.read<TicketCommunicationBloc>(),
      listener: (context, UiState state) {
        if (state is Success &&
            context.read<TicketCommunicationBloc>().state.getData()?.status ==
                200) {
          onSuccess?.call();
        } else if (state is Success &&
            context.read<TicketCommunicationBloc>().state.getData()?.status !=
                200) {
          ToastUtils().showToast(
            context,
            message: context
                    .read<TicketCommunicationBloc>()
                    .state
                    .getData()
                    ?.message ??
                'Unable to send message',
            toastStatus: ToastStatus.invalid,
          );
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
          return DotsProgressButton(
            btnHeight: appSize(context: context, unit: 10) / 4,
            btnWidth: appSize(context: context, unit: 10) / 2.2,
            style: AppStyle.bodyLarge(context).copyWith(
              color: Colors.white,
            ),
            isRectangularBorder: true,
            text: 'Send\nMessage',
            isProgress: true,
          );
        }
        return DotsProgressButton(
          btnHeight: appSize(context: context, unit: 10) / 4,
          btnWidth: appSize(context: context, unit: 10) / 2.2,
          style: AppStyle.bodyLarge(context).copyWith(
            color: Colors.white,
          ),
          isRectangularBorder: true,
          padding: EdgeInsets.zero,
          // text: 'Send\nMessage',
          child: Text(
            "Send\nMessage",
            textAlign: TextAlign.center,
            style: AppStyle.buttonStyle(context).copyWith(
                fontSize: appSize(context: context, unit: 10) / 15,
                fontWeight: FontWeight.w500),
          ),
          isProgress: false,
          onPressed: onSubmitMessage,
        );
      },
    );
  }
}
