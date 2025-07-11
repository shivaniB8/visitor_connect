import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/common/blocs/state_events/ui_state.dart';
import 'package:host_visitor_connect/common/custom_widget/app_action_dilog.dart';
import 'package:host_visitor_connect/common/custom_widget/dots_progress_button.dart';
import 'package:host_visitor_connect/common/res/paths.dart';

import 'package:host_visitor_connect/features/visitors/add_visitor/bloc/update_visitors_info_bloc.dart';

class UpdateVisitorInfoBuilder extends StatelessWidget {
  final Function()? onUpdate;
  final Function()? onSuccess;

  const UpdateVisitorInfoBuilder({
    Key? key,
    this.onUpdate,
    this.onSuccess,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: context.read<UpdateVisitorInfoBloc>(),
      listener: (context, UiState state) {
        if (state is Success) {
          if (context.read<UpdateVisitorInfoBloc>().state.getData()?.success ??
              false) {
            onSuccess?.call();
          } else {
            AppActionDialog.showActionDialog(
              image: "$icons_path/ErrorIcon.png",
              context: context,
              title: "Error occurred",
              subtitle: context
                      .read<UpdateVisitorInfoBloc>()
                      .state
                      .getData()
                      ?.message ??
                  "Something went wrong please\ntry again",
              child: DotsProgressButton(
                text: "Try Again",
                isRectangularBorder: true,
                buttonBackgroundColor: const Color(0xffF04646),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              showLeftSideButton: false,
            );
          }
        }
        if (state is Error) {
          AppActionDialog.showActionDialog(
            image: "$icons_path/ErrorIcon.png",
            context: context,
            title: "Error occurred",
            subtitle: context
                    .read<UpdateVisitorInfoBloc>()
                    .state
                    .getData()
                    ?.message ??
                "Something went wrong please\ntry again",
            child: DotsProgressButton(
              text: "Try Again",
              isRectangularBorder: true,
              buttonBackgroundColor: const Color(0xffF04646),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            showLeftSideButton: false,
          );
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
          onPressed: onUpdate,
        );
      },
    );
  }
}
