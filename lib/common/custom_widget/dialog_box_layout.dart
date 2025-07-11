import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/common/blocs/state_events/ui_state.dart';
import 'package:host_visitor_connect/common/custom_widget/title_bar_dialog.dart';
import 'package:host_visitor_connect/features/login/blocs/logout_bloc.dart';
import '../../../../common/res/styles.dart';
import '../res/colors.dart';
import 'button.dart';
import 'initializer.dart';

class DialogBoxLayout extends StatelessWidget {
  final bool? isProgress;
  final String? heading;
  final String? confirmationText;
  final Function()? onYesPressed;
  final Widget child;

  const DialogBoxLayout({
    Key? key,
    this.heading,
    this.confirmationText,
    this.onYesPressed,
    required this.child,
    this.isProgress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TitleBarDialog(
      headerTitle: heading ?? '',
      bodyContent: IgnorePointer(
        ignoring: context.watch<LogoutBloc>().state is Progress,
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                confirmationText ?? '',
                style: text_style_para1,
              ),

              // White space
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Initializer(child: child),
                  const SizedBox(
                    width: 12,
                  ),
                  Button(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 45,
                    ),
                    text: 'No',
                    isRectangularBorder: true,
                    backgroundColor: disabled_color,
                    onPressed: () {
                      Navigator.pop(context); // Close the dialog
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
