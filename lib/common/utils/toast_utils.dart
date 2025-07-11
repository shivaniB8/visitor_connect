import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:host_visitor_connect/common/app_toast.dart';

class ToastUtils {
  static final ToastUtils _toastUtils = ToastUtils._internal();
  static late FToast _fToast;

  factory ToastUtils() {
    return _toastUtils;
  }

  ToastUtils._internal() {
    _fToast = FToast();
  }

  void showToast(
    BuildContext context, {
    required String message,
    ToastStatus toastStatus = ToastStatus.neutral,
    ToastGravity? toastGravity = ToastGravity.TOP,
    bool isShort = true,
  }) {
    _fToast.init(context);
    _fToast.showToast(
      child: AppToast(
        toastMessage: message,
        status: toastStatus,
        onDismiss: () {
          removeCustomToast();
        },
      ),
      gravity: toastGravity,
      toastDuration: Duration(seconds: isShort ? 5 : 60),
    );
  }

  void showCustomToast(
    BuildContext context, {
    required Widget toast,
    ToastGravity toastGravity = ToastGravity.TOP,
    bool isShort = true,
  }) {
    _fToast.init(context);
    _fToast.showToast(
      child: toast,
      gravity: toastGravity,
      toastDuration: Duration(seconds: isShort ? 2 : 4),
    );
  }

  void removeCustomToast() {
    _fToast.removeCustomToast();
  }

  void removeAllQueuedToasts() {
    _fToast.removeQueuedCustomToasts();
  }
}
