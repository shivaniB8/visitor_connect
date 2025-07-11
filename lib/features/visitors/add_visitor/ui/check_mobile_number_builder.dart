import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/common/blocs/state_events/ui_state.dart';
import 'package:host_visitor_connect/common/custom_widget/dots_progress_button.dart';
import 'package:host_visitor_connect/common/utils/common_error_handler.dart';
import 'package:host_visitor_connect/features/visitors/add_visitor/bloc/check_mobile_number_bloc.dart';

class CheckMobileNumberBuilder extends StatelessWidget {
  final Function()? onSearch;
  final Function()? onSuccess;
  final Function(String errorMsg)? error;

  const CheckMobileNumberBuilder({
    Key? key,
    this.onSearch,
    this.onSuccess,
    this.error,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: context.read<CheckMobileNumberBloc>(),
      listener: (context, UiState state) {
        if (state is Success) {
          if (context.read<CheckMobileNumberBloc>().state.getData()?.success ??
              false) {
            onSuccess?.call();
          } else {
            error?.call(
              context.read<CheckMobileNumberBloc>().state.getData()?.message ??
                  'Something went wrong',
            );
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
            isRectangularBorder: true,
            text: 'Search',
            isProgress: true,
          );
        }
        return DotsProgressButton(
          isRectangularBorder: true,
          text: 'Search',
          isProgress: false,
          onPressed: onSearch,
        );
      },
    );
  }
}
