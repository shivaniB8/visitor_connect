import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/common/blocs/state_events/ui_state.dart';
import 'package:host_visitor_connect/common/custom_widget/app_action_dilog.dart';
import 'package:host_visitor_connect/common/custom_widget/app_bottomsheet.dart';
import 'package:host_visitor_connect/common/custom_widget/app_confirmation_screen.dart';
import 'package:host_visitor_connect/common/custom_widget/dots_progress_button.dart';
import 'package:host_visitor_connect/common/res/paths.dart';
import 'package:host_visitor_connect/common/utils/common_error_handler.dart';
import 'package:host_visitor_connect/common/utils/route_generator.dart';
import 'package:host_visitor_connect/features/visitors/visitor_listing/blocs/visitors_update_bloc.dart';

class UpdateVisitorsBuilder extends StatelessWidget {
  final Function()? onUpdateUserDetailsPressed;
  final bool? isOldVisitor;

  const UpdateVisitorsBuilder({
    Key? key,
    this.onUpdateUserDetailsPressed,
    this.isOldVisitor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: context.read<UpdateVisitorsBloc>(),
      listener: (context, UiState state) async {
        if (state is Success) {
          if ((context.read<UpdateVisitorsBloc>().state.getData()?.status ==
              200)) {
            Navigator.of(context).push(
              goToRoute(const ConfirmAppScreen(
                isFromVisitorEditScreen: true,
                img: '$icons_path/confirm.png',
                title: 'Confirmation',
                subtitle: "Visitor Update successfully",
              )),
            );
          }
          else if (context.read<UpdateVisitorsBloc>().state.getData()?.status !=
              200) {
            AppActionDialog.showActionDialog(
              image: "$icons_path/ErrorIcon.png",
              context: context,
              title: "Error occurred",
              subtitle: context.read<UpdateVisitorsBloc>().state.getData()?.message ??
                  'Unable to process your data right now',
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
            text: 'Update Visitor',
            isProgress: true,
          );
        }
        return DotsProgressButton(
          isRectangularBorder: true,
          text: 'Update Visitor',
          isProgress: false,
          onPressed: onUpdateUserDetailsPressed,
        );
      },
    );
  }
}
