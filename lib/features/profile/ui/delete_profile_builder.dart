import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/common/blocs/state_events/ui_state.dart';
import 'package:host_visitor_connect/common/custom_widget/app_action_dilog.dart';
import 'package:host_visitor_connect/common/custom_widget/app_bottomsheet.dart';
import 'package:host_visitor_connect/common/custom_widget/dots_progress_button.dart';
import 'package:host_visitor_connect/common/res/paths.dart';
import 'package:host_visitor_connect/common/shared_prefs.dart';
import 'package:host_visitor_connect/common/utils/route_generator.dart';
import 'package:host_visitor_connect/features/login/ui/login_page.dart';
import 'package:host_visitor_connect/features/login/ui/login_provider.dart';
import 'package:host_visitor_connect/features/profile/bloc/delete_account_bloc.dart';

class DeleteProfileBuilder extends StatelessWidget {
  final Function()? onSetAsPrimaryPressed;

  const DeleteProfileBuilder({
    Key? key,
    this.onSetAsPrimaryPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: context.read<DeleteAccountBloc>(),
      listener: (context, UiState state) {
        if (state is Success &&
            (context.read<DeleteAccountBloc>().state.getData()?.success ??
                false)) {
          SharedPrefs.clearUserData();
          AppBottomSheet.showAppSnackBar(
            context: context,
            text: "Profile Delete Successfully",
          );
          Navigator.pushAndRemoveUntil(
              context,
              goToRoute(
                const LoginProvider(
                  child: LoginPage(),
                ),
              ),
              // MaterialPageRoute(
              //   builder: (context) => const LoginProvider(
              //     child: LoginPage(),
              //   ),
              // ),
              (route) => false);
        } else if (state is Success &&
            (!(context.read<DeleteAccountBloc>().state.getData()?.success ??
                false))) {
          AppActionDialog.showActionDialog(
            image: "$icons_path/ErrorIcon.png",
            context: context,
            title: "Error occurred",
            subtitle:
                context.read<DeleteAccountBloc>().state.getData()?.message ??
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
        if (state is Error) {
          AppActionDialog.showActionDialog(
            image: "$icons_path/ErrorIcon.png",
            context: context,
            title: "Error occurred",
            subtitle:
                context.read<DeleteAccountBloc>().state.getData()?.message ??
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
      builder: (context, state) {
        if (state is Progress) {
          return const DotsProgressButton(
            isRectangularBorder: true,
            expanded: true,
            text: "",
            isProgress: true,
            buttonBackgroundColor: Color(0xffF04646),
          );
        }
        return DotsProgressButton(
          text: "Delete",
          expanded: true,
          isRectangularBorder: true,
          buttonBackgroundColor: const Color(0xffF04646),
          onPressed: onSetAsPrimaryPressed,
        );
      },
    );
  }
}
