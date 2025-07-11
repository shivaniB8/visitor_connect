import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/common/blocs/state_events/ui_state.dart';
import 'package:host_visitor_connect/common/custom_widget/app_action_dilog.dart';
import 'package:host_visitor_connect/common/custom_widget/dots_progress_button.dart';
import 'package:host_visitor_connect/common/res/paths.dart';
import 'package:host_visitor_connect/features/rentals/bloc/driving_licence_bloc.dart';

class DrivingLicenceBuilder extends StatelessWidget {
  final Function()? onGetData;
  final Function()? onSuccess;
  final Function(String? msg)? onError;

  const DrivingLicenceBuilder({
    Key? key,
    this.onGetData,
    this.onSuccess,
    this.onError,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: context.read<DrivingLicenseBloc>(),
      listener: (context, UiState state) {
        if (state is Success) {
          if (context.read<DrivingLicenseBloc>().state.getData()?.status == 200) {
            onSuccess?.call();
          } else if (!(context.read<DrivingLicenseBloc>().state.getData()?.success ?? false)) {
            AppActionDialog.showActionDialog(
              image: "$icons_path/ErrorIcon.png",
              context: context,
              title: "Error occurred",
              subtitle: context.read<DrivingLicenseBloc>().state.getData()?.message ??
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
            subtitle: context.read<DrivingLicenseBloc>().state.getData()?.message ??
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
            // disableButton: true,
            isRectangularBorder: true,
            text: 'Verify',
            isProgress: true,
          );
        }
        return DotsProgressButton(
          isRectangularBorder: true,
          text: 'Verify',
          isProgress: false,
          onPressed: onGetData,
        );
      },
    );
  }
}
