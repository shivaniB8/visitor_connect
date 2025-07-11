import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/common/blocs/state_events/ui_state.dart';
import 'package:host_visitor_connect/common/custom_widget/dots_progress_button.dart';
import 'package:host_visitor_connect/common/utils/common_error_handler.dart';

import 'package:host_visitor_connect/features/report/report_list/bloc/report_visitor_bloc.dart';

class ReportVisitorBuilder extends StatelessWidget {
  final Function()? onReportVisitorPressed;
  final Function()? onSuccess;

  const ReportVisitorBuilder({
    Key? key,
    this.onReportVisitorPressed,
    this.onSuccess,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: context.read<ReportVisitorBloc>(),
      listener: (context, UiState state) {
        if (state is Success) {
          if (context.read<ReportVisitorBloc>().state.getData()?.status ==
              200) {
            onSuccess?.call();
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
            text: 'Report Visitor',
            isProgress: true,
          );
        }
        return DotsProgressButton(
          isRectangularBorder: true,
          text: 'Report Visitor',
          isProgress: false,
          onPressed: onReportVisitorPressed,
        );
      },
    );
  }
}
