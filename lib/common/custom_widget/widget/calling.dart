import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/common/res/paths.dart';
import 'package:host_visitor_connect/common/custom_widget/widget/calling_dialog.dart';
import 'package:host_visitor_connect/common/utils/utils.dart';
import 'package:host_visitor_connect/features/visitors/visitor_listing/blocs/outgoing_call_bloc.dart';
import 'package:host_visitor_connect/features/visitors/visitor_listing/blocs/virtual_numbers_bloc.dart';

class CallingWidget extends StatelessWidget {
  final int visitorId;
  final int settingId;
  final double? height;
  final double? width;
  final double? circularRadius;
  final double? horizontalPadding;
  final double? verticalPadding;

  const CallingWidget(
      {super.key,
      required this.visitorId,
      required this.settingId,
      this.circularRadius,
      this.height,
      this.width,
      this.horizontalPadding,
      this.verticalPadding});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if ((context.read<VirtualNumbersBloc>().state.getData()?.count ?? 0) >
            1) {
          CallingDialog.showListPopup(context: context, visitorId: visitorId);
        } else if ((context.read<VirtualNumbersBloc>().state.getData()?.count ??
                0) ==
            1) {
          context.read<OutgoingCallBloc>().outgoingCall(
              visitorId: visitorId,
              settingId: context
                      .read<VirtualNumbersBloc>()
                      .state
                      .getData()
                      ?.records
                      ?.first
                      .settingId ??
                  0);
        }
      },
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: const Color(0xff173C84),
          borderRadius: BorderRadius.circular(circularRadius ?? 20),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding ?? 10,
              vertical: verticalPadding ?? 6),
          child: Image.asset(
            '$icons_path/phone.png',
            height: sizeHeight(context) / 35,
            width: sizeHeight(context) / 20,
          ),
        ),
      ),
    );
  }
}
