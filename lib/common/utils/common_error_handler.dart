import 'package:flutter/material.dart';
import 'package:host_visitor_connect/common/app_toast.dart';
import 'package:host_visitor_connect/common/extensions/exception_extensions.dart';
import 'package:host_visitor_connect/common/utils/toast_utils.dart';
import 'package:host_visitor_connect/common/utils/utils.dart';

import '../exceptions/general_exception.dart';

class CommonErrorHandler {
  final BuildContext context;
  final Exception exception;

  CommonErrorHandler(
    this.context, {
    required this.exception,
  });

  _Toast _getToast() {
    if (exception.isConnectionException()) {
      //internet error
      return _Toast(
        message: 'No Internet',
        status: ToastStatus.invalid,
      );
    } else if (exception is GeneralException) {
      return _Toast(
        status: ToastStatus.invalid,
        message: exception.toString().isEmpty
            ? 'App error unknown'
            : exception.toString(),
        isShort: false,
      );
    } else {
      return _Toast(
        status: ToastStatus.invalid,
        message: 'App error unknown',
      );
    }
  }

  void showToast() {
    afterBuild(() {
      final toast = _getToast();

      // Showing toast
      ToastUtils().showCustomToast(
        context,
        toast: AppToast(
          status: toast.status,
          toastMessage: toast.message,
          onDismiss: () {
            ToastUtils().removeCustomToast();
          },
        ),
        isShort: toast.isShort,
      );

      //TODO: Show error screens for generic HTTP status codes 404, 500, etc
    });
  }
}

/// UI model to represent a toast
class _Toast {
  final ToastStatus status;
  final String message;
  final bool isShort;

  _Toast({
    this.status = ToastStatus.neutral,
    required this.message,
    this.isShort = true,
  });
}
