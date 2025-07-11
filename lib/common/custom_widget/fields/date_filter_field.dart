import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';

import '../../../generated/l10n.dart';
import '../../res/colors.dart';
import '../../res/styles.dart';
import 'form_field_label.dart';

class DateTimeFieldFilter extends StatelessWidget {
  final String fieldName;
  final String? label;
  final DateTime? initialValue;
  final Function(DateTime?)? onChanged;
  final bool isRequired;
  final InputType inputType;
  final DateFormat? format;
  final DateTime? firstSelectableDate;
  final DateTime? lastSelectableDate;
  final List<String Function(DateTime?)> validators;
  final String? hintText;
  final String? requiredValidatorFieldName;
  final DateTime? initialDate;
  final InputDecoration? decoration;
  final TextStyle? style;
  final Color? fillColor;

  const DateTimeFieldFilter({
    Key? key,
    required this.fieldName,
    this.fillColor = textFeildFillColor,
    this.label,
    this.initialValue,
    this.onChanged,
    this.isRequired = false,
    this.inputType = InputType.both,
    this.format,
    this.firstSelectableDate,
    this.lastSelectableDate,
    this.validators = const [],
    this.hintText,
    this.requiredValidatorFieldName,
    this.initialDate,
    this.decoration,
    this.style,
  }) : super(key: key);

  DateFormat _getDateFormat() {
    if (format != null) {
      return format!;
    }
    if (inputType == InputType.time) {
      return DateFormat('hh:mm a');
    } else if (inputType == InputType.date) {
      return DateFormat('dd MMM yyy');
    } else {
      return DateFormat('dd MMM yyy | hh:mm a');
    }
  }

  Widget _getSuffixIcon() {
    return Icon(
      inputType == InputType.time ? Icons.watch_later : Icons.date_range,
      color: gray_color,
    );
  }

  String _getHintText() {
    if (hintText != null) return hintText!;
    if (inputType == InputType.date) {
      return "Select Date";
    } else if (inputType == InputType.time) {
      return "Select Time";
    }
    return "Select";
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FormFieldLabel(label: label),
        Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              error: Colors.red,
              primary: light_blue_color, // header background color
              onPrimary: Colors.white, // header text color
              onSurface: buttonColor, // body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: buttonColor, // button text color
              ),
            ),
          ),
          child: FormBuilderDateTimePicker(
            name: fieldName,
            inputType: inputType,
            onChanged: onChanged,
            format: _getDateFormat(),
            initialValue: initialValue,
            firstDate: firstSelectableDate,
            lastDate: lastSelectableDate,
            initialDate: initialDate,
            currentDate: initialDate,
            style: style ??
                AppStyle.bodyLarge(context).copyWith(color: filterTextColor),

            // Decoration
            decoration: decoration ??
                form_field_input_decoration.copyWith(
                    suffixIconConstraints: const BoxConstraints(maxHeight: 28),
                    suffixIcon: _getSuffixIcon(),
                    hintText: _getHintText(),
                    hintStyle: AppStyle.bodyMedium(context).copyWith(
                      color: gray_color,
                      fontWeight: FontWeight.w400,
                    ),
                    constraints: const BoxConstraints(maxHeight: 36),
                    fillColor: fillColor,
                    filled: true),

            //validation
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: FormBuilderValidators.compose([
              if (isRequired)
                FormBuilderValidators.required(
                  errorText: S.of(context).formField_error_isEmpty(
                      requiredValidatorFieldName ?? ''),
                ),
              ...validators,
            ]),
          ),
        ),
      ],
    );
  }
}
