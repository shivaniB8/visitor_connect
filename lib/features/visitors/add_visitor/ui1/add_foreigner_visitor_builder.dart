import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/common/blocs/state_events/ui_state.dart';
import 'package:host_visitor_connect/common/custom_widget/dots_progress_button.dart';
import 'package:host_visitor_connect/common/utils/common_error_handler.dart';
import 'package:host_visitor_connect/features/visitors/add_visitor/bloc/add_foreigner_visitor_bloc.dart';

class AddForeignerVisitorBuilder extends StatelessWidget {
  final Function()? onAddVisitorPressed;
  final Function()? onSuccess;
  final Function(String)? onError;
  final Function(bool appError)? appError;

  const AddForeignerVisitorBuilder({
    Key? key,
    this.onAddVisitorPressed,
    this.onSuccess,
    this.onError,
    this.appError,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: context.read<AddForeignerVisitorBloc>(),
      listener: (context, UiState state) {
        if (state is Success &&
            context.read<AddForeignerVisitorBloc>().state.getData()?.statusCode == 200) {
          onSuccess?.call();
        } else if (state is Success &&
            context.read<AddForeignerVisitorBloc>().state.getData()?.statusCode != 200) {
          onError?.call(
            context.read<AddForeignerVisitorBloc>().state.getData()?.message ??
                'Unable to Add visitor, Try after some time',
          );
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
        if (state is Progress) {
          return const DotsProgressButton(
            isRectangularBorder: true,
            text: 'Update Details',
            isProgress: true,
          );
        }
        return DotsProgressButton(
          isRectangularBorder: true,
          text: 'Update Details',
          isProgress: false,
          onPressed: onAddVisitorPressed,
        );
      },
    );
  }
}
