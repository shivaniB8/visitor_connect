import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:host_visitor_connect/common/utils/toast_utils.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';

class FormErrorBuilder {
  static GlobalKey<FormBuilderState> _getFormKey(BuildContext context) {
    return context.read<GlobalKey<FormBuilderState>>();
  }

  static FormBuilderFieldState? _getFirstInvalidField(BuildContext context) {
    final formBuilderState = _getFormKey(context);
    return formBuilderState.currentState?.fields.values.firstWhereOrNull(
      (fieldState) => !fieldState.isValid,
    );
  }

  static bool validateFormAndShowErrors(BuildContext context) {
    final formStatus = _getFormKey(context).currentState!.validate();
    if (!formStatus) {
      final invalidFields = _getFirstInvalidField(context);
      if (invalidFields != null) {
        ToastUtils().showToast(
          context,
          message: invalidFields.errorText ?? '',
        );
      }
    }
    return formStatus;
  }
}
