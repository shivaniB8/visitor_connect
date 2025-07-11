// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/common/blocs/state_events/ui_state.dart';
import 'package:host_visitor_connect/common/custom_widget/app_action_dilog.dart';
import 'package:host_visitor_connect/common/custom_widget/app_bottomsheet.dart';
import 'package:host_visitor_connect/common/custom_widget/dots_progress_button.dart';
import 'package:host_visitor_connect/common/res/paths.dart';
import 'package:host_visitor_connect/common/utils/route_generator.dart';
import 'package:host_visitor_connect/features/dashboard/bloc/user_details_bloc.dart';
import 'package:host_visitor_connect/features/dashboard/ui/home_page.dart';
import 'package:host_visitor_connect/features/profile/bloc/update_profile_bloc.dart';

class UpdateProfileBuilder extends StatelessWidget {
  final Function()? onUpdateUserDetailsPressed;

  const UpdateProfileBuilder({
    Key? key,
    this.onUpdateUserDetailsPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: context.read<UpdateProfileBloc>(),
      listener: (context, UiState state) async {
        if (state is Success &&
            context.read<UpdateProfileBloc>().state.getData()?.status == 200) {
          await context.read<UserDetailsBloc>().userDetails();
          if ((context.read<UpdateProfileBloc>().state.getData()?.status ==
              200)) {
            AppBottomSheet.showAppSnackBar(
              context: context,
              text: "Profile Update Successfully",
            );
            Navigator.of(context).pushAndRemoveUntil(
              goToRoute(
                const HomePage(),
              ),
              // MaterialPageRoute(
              //   builder: (context) {
              //     return const HomePage();
              //   },
              // ),
              (route) => false,
            );
          } else if (context
                  .read<UpdateProfileBloc>()
                  .state
                  .getData()
                  ?.status !=
              200) {
            AppActionDialog.showActionDialog(
              image: "$icons_path/ErrorIcon.png",
              context: context,
              title: "Error occurred",
              subtitle:
                  context.read<UpdateProfileBloc>().state.getData()?.message ??
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
        } else if (state is Error) {
          AppActionDialog.showActionDialog(
            image: "$icons_path/ErrorIcon.png",
            context: context,
            title: "Error occurred",
            subtitle: "Something went wrong please\ntry again",
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
            text: 'Update Profile',
            isProgress: true,
          );
        }
        return DotsProgressButton(
          isRectangularBorder: true,
          text: 'Update Profile',
          isProgress: false,
          onPressed: onUpdateUserDetailsPressed,
        );
      },
    );
  }
}
