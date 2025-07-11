import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/common/app_toast.dart';
import 'package:host_visitor_connect/common/blocs/state_events/ui_state.dart';
import 'package:host_visitor_connect/common/custom_widget/dots_progress_button.dart';
import 'package:host_visitor_connect/common/res/paths.dart';
import 'package:host_visitor_connect/common/res/styles.dart';
import 'package:host_visitor_connect/common/utils/common_error_handler.dart';
import 'package:host_visitor_connect/common/utils/toast_utils.dart';
import 'package:host_visitor_connect/features/payment_pateways/razorpay/bloc/razor_pay_order_bloc.dart';

class RazorPayOrderBuilder extends StatelessWidget {
  final Function()? onPressed;
  final Function()? onSuccess;

  const RazorPayOrderBuilder({
    Key? key,
    this.onPressed,
    this.onSuccess,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double imgSize = appSize(context: context, unit: 10) / 5;
    double fontSize = appSize(context: context, unit: 10) / 13;
    return BlocConsumer(
      bloc: context.read<RazorPayOrderBloc>(),
      listener: (context, UiState state) {
        if (state is Success &&
            context.read<RazorPayOrderBloc>().state.getData()?.status == 200) {
          onSuccess?.call();
        } else if (state is Success &&
            context.read<RazorPayOrderBloc>().state.getData()?.status != 200) {
          ToastUtils().showToast(
            context,
            message:
                context.read<RazorPayOrderBloc>().state.getData()?.message ??
                    'Unable to Add voter, Try after some time',
            toastStatus: ToastStatus.invalid,
          );
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
          return DotsProgressButton(
            isRectangularBorder: true,
            isProgress: true,
            child: Row(
              children: [
                Text(
                  'Proceed',
                  style: AppStyle.headlineSmall(context)
                      .copyWith(color: Colors.white),
                ),
                const SizedBox(
                  width: 20,
                ),
                Image.asset(
                  '$icons_path/arrow_forward.png',
                  height: 30,
                  width: 30,
                ),
              ],
            ),
          );
        }
        return DotsProgressButton(
          isRectangularBorder: true,
          isProgress: false,
          onPressed: onPressed,
          child: Row(
            children: [
              Text(
                'Proceed',
                style: AppStyle.headlineSmall(context)
                    .copyWith(color: Colors.white, fontSize: fontSize),
              ),
              const SizedBox(
                width: 20,
              ),
              Image.asset(
                '$icons_path/arrow_forward.png',
                height: imgSize - 20,
                width: imgSize - 20,
              ),
            ],
          ),
        );
      },
    );
  }
}
