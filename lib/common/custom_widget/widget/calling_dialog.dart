import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/common/blocs/state_events/ui_state.dart';
import 'package:host_visitor_connect/common/custom_widget/app_action_dilog.dart';
import 'package:host_visitor_connect/common/custom_widget/dots_progress_button.dart';
import 'package:host_visitor_connect/common/custom_widget/title_bar_dialog.dart';
import 'package:host_visitor_connect/common/extensions/string_extensions.dart';
import 'package:host_visitor_connect/common/res/paths.dart';
import 'package:host_visitor_connect/common/res/styles.dart';
import 'package:host_visitor_connect/common/utils/utils.dart';
import 'package:host_visitor_connect/features/visitors/visitor_listing/blocs/outgoing_call_bloc.dart';
import 'package:host_visitor_connect/features/visitors/visitor_listing/blocs/virtual_numbers_bloc.dart';
import 'package:provider/provider.dart';

import '../../res/colors.dart';

class CallingDialog {
  static void showListPopup(
      {required BuildContext context, required int visitorId}) {
    final virtualNumbers =
        context.read<VirtualNumbersBloc>().state.getData()?.records;
    showDialog(
      context: context,
      builder: (_) {
        return MultiProvider(
          providers: [
            BlocProvider.value(
              value: context.read<OutgoingCallBloc>(),
            ),
          ],
          child: TitleBarDialog(
            headerTitle: "Call",
            bodyContent: BlocConsumer(
              bloc: context.read<OutgoingCallBloc>(),
              listener: (context, state) {
                if (state is Success) {
                  AppActionDialog.showActionDialog(
                    image: "$icons_path/confirm.png",
                    context: context,
                    title: "Success",
                    success: true,
                    subtitle:
                        "call has triggered successfully, You will get call in sometime",
                    child: DotsProgressButton(
                      text: "Done",
                      isRectangularBorder: true,
                      buttonBackgroundColor: Colors.green.shade400,
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                    ),
                    showLeftSideButton: false,
                  );
                } else if (state is Success &&
                    context.read<OutgoingCallBloc>().state.getData()?.success ==
                        false) {
                  AppActionDialog.showActionDialog(
                    image: "$icons_path/ErrorIcon.png",
                    context: context,
                    title: "Error occurred",
                    subtitle: context
                            .read<OutgoingCallBloc>()
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
                } else if (state is Error) {
                  AppActionDialog.showActionDialog(
                    image: "$icons_path/ErrorIcon.png",
                    context: context,
                    title: "Error occurred",
                    subtitle: context
                            .read<OutgoingCallBloc>()
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
              builder: (_, UiState state) => ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.only(
                    top: 10, left: 10, right: 10, bottom: 10),
                itemCount: virtualNumbers!.length + 1,
                itemBuilder: (context, index) {
                  if (index < virtualNumbers.length) {
                    return Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(5),
                        highlightColor: primary_color.withOpacity(0.2),
                        splashColor: primary_color.withOpacity(0.3),
                        onTap: () {
                          context.read<OutgoingCallBloc>().outgoingCall(
                              visitorId: visitorId,
                              settingId: virtualNumbers[index].settingId ?? 0);
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: sizeHeight(context) / 60,
                            horizontal: 10,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                virtualNumbers[index].virtualNumber ?? '',
                                style: AppStyle.bodyMedium(context)
                                    .copyWith(fontWeight: FontWeight.w500)
                                    .copyWith(color: primary_color),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              if (!(virtualNumbers[index]
                                  .actualNumber
                                  .isNullOrEmpty()))
                                Text(
                                  '(${virtualNumbers[index].actualNumber ?? ''})',
                                  style: AppStyle.bodyMedium(context).copyWith(
                                      color: gray_color,
                                      fontWeight: FontWeight.w500),
                                ),
                            ],
                          ),
                        ),
                      ),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
