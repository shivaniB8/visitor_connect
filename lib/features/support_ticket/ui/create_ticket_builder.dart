import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/common/app_toast.dart';
import 'package:host_visitor_connect/common/blocs/state_events/ui_state.dart';
import 'package:host_visitor_connect/common/custom_widget/dots_progress_button.dart';
import 'package:host_visitor_connect/common/res/styles.dart';
import 'package:host_visitor_connect/common/utils/common_error_handler.dart';
import 'package:host_visitor_connect/common/utils/toast_utils.dart';
import 'package:host_visitor_connect/features/support_ticket/bloc/create_ticket_bloc.dart';

class CreateTicketBuilder extends StatelessWidget {
  final Function()? onCreateTicket;
  final Function()? onSuccess;

  const CreateTicketBuilder({
    Key? key,
    this.onCreateTicket,
    this.onSuccess,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: context.read<CreateTicketBloc>(),
      listener: (context, UiState state) {
        if (state is Success &&
            context.read<CreateTicketBloc>().state.getData()?.status == 200) {
          onSuccess?.call();
        } else if (state is Success &&
            context.read<CreateTicketBloc>().state.getData()?.status != 200) {
          ToastUtils().showToast(
            context,
            message:
                context.read<CreateTicketBloc>().state.getData()?.message ??
                    'Unable to create ticket',
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
            style: AppStyle.bodyLarge(context).copyWith(
              color: Colors.white,
            ),
            isRectangularBorder: true,
            text: 'Create Ticket',
            isProgress: true,
          );
        }
        return DotsProgressButton(
          style: AppStyle.bodyLarge(context).copyWith(
            color: Colors.white,
          ),
          isRectangularBorder: true,
          text: 'Create Ticket',
          isProgress: false,
          onPressed: onCreateTicket,
        );
      },
    );
  }
}
