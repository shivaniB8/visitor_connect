import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/common/blocs/state_events/ui_state.dart';
import 'package:host_visitor_connect/common/custom_widget/dots_progress_button.dart';
import 'package:host_visitor_connect/common/utils/common_error_handler.dart';
import 'package:host_visitor_connect/features/visitors/add_visitor/bloc/update_visitors_info_bloc.dart';

class UpdateVisitorInfoBuilder extends StatelessWidget {
  final Function()? onUpdate;
  final Function()? onSuccess;
  final Function(String errorMsg)? error;
  final Function(bool appError)? appError;

  const UpdateVisitorInfoBuilder({
    Key? key,
    this.onUpdate,
    this.onSuccess,
    this.error,
    this.appError,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: context.read<UpdateVisitorInfoBloc>(),
      listener: (context, UiState state) {
        if (state is Success) {
          if (context.read<UpdateVisitorInfoBloc>().state.getData()?.success ?? false) {
            onSuccess?.call();
          } else {
            error?.call(
              context.read<UpdateVisitorInfoBloc>().state.getData()?.message ??
                  'Something went wrong',
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
        if (state is Progress) {
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            child: const DotsProgressButton(
              isRectangularBorder: true,
              text: 'Save',
              isProgress: true,
            ),
          );
        }
        return SizedBox(
          width: MediaQuery.of(context).size.width,
          child: DotsProgressButton(
            isRectangularBorder: true,
            text: 'Save',
            isProgress: false,
            onPressed: onUpdate,
          ),
        );
      },
    );
  }
}
