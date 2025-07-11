import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/common/app_toast.dart';
import 'package:host_visitor_connect/common/blocs/state_events/ui_state.dart';
import 'package:host_visitor_connect/common/custom_widget/dots_progress_button.dart';
import 'package:host_visitor_connect/common/res/styles.dart';
import 'package:host_visitor_connect/common/utils/common_error_handler.dart';
import 'package:host_visitor_connect/common/utils/toast_utils.dart';
import 'package:host_visitor_connect/features/support_ticket/bloc/cancel_ticket_bloc.dart';

class CancelTicketBuilder extends StatelessWidget {
  final Function()? onCancelTicket;
  final Function()? onSuccess;

  const CancelTicketBuilder({
    Key? key,
    this.onCancelTicket,
    this.onSuccess,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: context.read<CancelTicketBloc>(),
      listener: (context, UiState state) {
        if (state is Success &&
            context.read<CancelTicketBloc>().state.getData()?.status == 200) {
          onSuccess?.call();
        } else if (state is Success &&
            context.read<CancelTicketBloc>().state.getData()?.status != 200) {
          ToastUtils().showToast(
            context,
            message:
                context.read<CancelTicketBloc>().state.getData()?.message ??
                    'Unable to cancel ticket',
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
          return const DotsProgressButton(
            isRectangularBorder: true,
            text: 'Yes, Cancel',
            isProgress: true,
          );
        }
        return DotsProgressButton(
          isRectangularBorder: true,
          isProgress: false,
          onPressed: onCancelTicket,
          child: Text(
            'Yes, Cancel',
            style: AppStyle.bodySmall(context)
                .copyWith(color: Colors.white, fontWeight: FontWeight.w700),
          ),
        );
      },
    );
  }
}
