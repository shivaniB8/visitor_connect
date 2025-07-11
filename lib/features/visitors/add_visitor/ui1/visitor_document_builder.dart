import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/common/blocs/state_events/ui_state.dart';
import 'package:host_visitor_connect/common/custom_widget/dots_progress_button.dart';
import 'package:host_visitor_connect/common/utils/common_error_handler.dart';
import 'package:host_visitor_connect/features/visitors/add_visitor/bloc/visitor_document_bloc.dart';

class VisitorDocumentBuilder extends StatelessWidget {
  final Function()? onSuccess;
  final Function()? onSubmitPressed;
  final Function(String? error)? onError;

  const VisitorDocumentBuilder({
    Key? key,
    this.onSuccess,
    this.onSubmitPressed,
    this.onError,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: context.read<VisitorDocumentBloc>(),
      listener: (context, UiState state) {
        if (state is Success &&
            (context.read<VisitorDocumentBloc>().state.getData()?.success ?? false)) {
          onSuccess?.call();
        } else if (!(context.read<VisitorDocumentBloc>().state.getData()?.success ?? false)) {
          onError?.call(context.read<VisitorDocumentBloc>().state.getData()?.message);
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
            text: 'Submit',
            isProgress: true,
          );
        }
        return DotsProgressButton(
          isRectangularBorder: true,
          text: 'Submit',
          isProgress: false,
          onPressed: onSubmitPressed,
        );
      },
    );
  }
}
