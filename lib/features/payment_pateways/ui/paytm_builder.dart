import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/common/app_toast.dart';
import 'package:host_visitor_connect/common/blocs/state_events/ui_state.dart';
import 'package:host_visitor_connect/common/custom_widget/dots_progress_button.dart';
import 'package:host_visitor_connect/common/res/paths.dart';
import 'package:host_visitor_connect/common/res/styles.dart';
import 'package:host_visitor_connect/common/utils/common_error_handler.dart';
import 'package:host_visitor_connect/common/utils/toast_utils.dart';
import 'package:host_visitor_connect/features/payment_pateways/paytm/bloc/paytm_token_bloc.dart';

class PaytmBuilder extends StatelessWidget {
  final Function()? onPressed;
  final Function()? onSuccess;

  const PaytmBuilder({
    Key? key,
    this.onPressed,
    this.onSuccess,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: context.read<PaytmTokenBloc>(),
      listener: (context, UiState state) {
        if (state is Success &&
            context.read<PaytmTokenBloc>().state.getData()?.status == 200) {
          onSuccess?.call();
        } else if (state is Success &&
            context.read<PaytmTokenBloc>().state.getData()?.status != 200) {
          ToastUtils().showToast(
            context,
            message: context.read<PaytmTokenBloc>().state.getData()?.message ??
                'Unable to Proceed at this, Please Try after some time',
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
            expanded: true,
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
          expanded: true,
          onPressed: onPressed,
          child: Row(
            children: [
              const Spacer(),
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
              const Spacer(),
            ],
          ),
        );
      },
    );
  }
}
