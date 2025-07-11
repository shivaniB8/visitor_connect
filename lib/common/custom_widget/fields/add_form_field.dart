import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:host_visitor_connect/common/custom_widget/fields/form_field_label.dart';
import 'package:host_visitor_connect/common/extensions/string_extensions.dart';
import 'package:host_visitor_connect/common/res/colors.dart';
import 'package:host_visitor_connect/common/res/styles.dart';
import 'package:host_visitor_connect/common/utils/utils.dart';

class AddFormField extends StatelessWidget {
  final TextInputType? keyboardType;
  final String? hintText;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final bool? isMobileNumber;
  final String? label;
  final int? minLines;
  final int? maxLines;
  final bool isEnable;
  final bool isEnable2;
  final String? initialValue;
  final TextEditingController? controller;
  final bool? isRequired;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;
  final bool maxLengthEnforced;
  final String? errorMsg;
  final FocusNode? focusNode;
  final bool obscureText;
  final bool? isReadOnly;
  final TextCapitalization? textCapitalization;
  final String? countryCode;
  final EdgeInsets? padding;
  final Widget? suffixIcon;
  final Function()? onPrefixClick;
  final double? textfieldHeight;
  final Color? fillColor;
  final bool? onlyLoginPage;
  final bool? reportFilter;
  final Color? cursorColor;
  final Widget? prefixIcon;
  final bool? showPrefix;
  final String? title;
  final TextStyle? style;
  final Function()? onTap;

  const AddFormField({
    super.key,
    this.keyboardType,
    this.suffixIcon,
    this.hintText,
    this.onlyLoginPage = false,
    this.cursorColor = text_color,
    this.textfieldHeight,
    this.onChanged,
    this.validator,
    this.label,
    this.style,
    this.isMobileNumber = false,
    this.minLines,
    this.maxLines,
    this.reportFilter,
    this.controller,
    this.initialValue,
    this.isEnable = true,
    this.isEnable2 = false,
    this.isRequired = false,
    this.inputFormatters,
    this.maxLengthEnforced = false,
    this.maxLength,
    this.errorMsg,
    this.textCapitalization,
    this.focusNode,
    this.obscureText = false,
    this.isReadOnly,
    this.countryCode = '0',
    this.onPrefixClick,
    this.padding,
    this.fillColor,
    this.prefixIcon,
    this.showPrefix,
    this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FormFieldLabel(
          label: label,
          isRequired: isRequired,
          style: style,
        ),
        if (!(label.isNullOrEmpty()))
          const SizedBox(
            height: 10,
          ),
        TextFormField(
          textCapitalization: textCapitalization ?? TextCapitalization.words,
          textAlign: TextAlign.start,
          textAlignVertical: TextAlignVertical.center,
          obscureText: obscureText,
          readOnly: isReadOnly ?? false,
          maxLines: maxLines,
          maxLength: maxLength,
          initialValue: initialValue,
          minLines: minLines,
          enabled: isEnable,
          keyboardType: keyboardType,
          onTap: onTap,
          inputFormatters: inputFormatters,
          decoration: InputDecoration(
              counter: const Offstage(),
              suffixIcon: suffixIcon,
              prefixIcon: isMobileNumber ?? false
                  ? InkWell(
                      onTap: onPrefixClick,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '+ $countryCode',
                            style: AppStyle.bodySmall(context).copyWith(
                                color: onlyLoginPage == true
                                    ? primary_text_color
                                    : isEnable || isEnable2
                                        ? text_color
                                        : gray_color,
                                fontWeight: FontWeight.w400),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Container(
                            color: onlyLoginPage == true
                                ? primary_text_color
                                : isEnable || isEnable2
                                    ? text_color
                                    : gray_color,
                            width: 1,
                          ),
                        ],
                      ),
                    )
                  : showPrefix ?? false
                      ? prefixIcon ??
                          InkWell(
                            onTap: onPrefixClick,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 15.0),
                                  child: Text(
                                    '+ $countryCode',
                                    style: AppStyle.bodySmall(context).copyWith(
                                        color: onlyLoginPage == true
                                            ? primary_text_color
                                            : isEnable
                                                ? text_color
                                                : gray_color,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                                const SizedBox(width: 20),
                                Container(
                                  color: text_color,
                                  width: 1,
                                ),
                              ],
                            ),
                          )
                      : null,
              prefixIconConstraints: isMobileNumber ?? false
                  ? BoxConstraints(
                      maxHeight: sizeHeight(context) / 24,
                      maxWidth: sizeWidth(context) / 6)
                  : null,
              contentPadding: padding ??
                  const EdgeInsets.only(
                    left: 14,
                    top: 0,
                    right: 15,
                    bottom: 0,
                  ),
              counterText: "",
              enabledBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                  borderSide: BorderSide(
                      width: onlyLoginPage == true ? 1.5 : 0.5,
                      color: onlyLoginPage == true
                          ? primary_text_color
                          : Colors.grey.withOpacity(0.2))),
              disabledBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                  borderSide: BorderSide(
                      width: onlyLoginPage == true ? 1.5 : 0.5,
                      color: onlyLoginPage == true
                          ? primary_text_color
                          : Colors.grey.withOpacity(0.2))),
              focusedBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                  borderSide: BorderSide(
                      width: onlyLoginPage == true ? 1.5 : 0.5,
                      color: onlyLoginPage == true
                          ? primary_text_color
                          : Colors.grey.withOpacity(0.2))),
              border: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                  borderSide: BorderSide(
                      width: onlyLoginPage == true ? 1.5 : 0.5,
                      color: onlyLoginPage == true
                          ? primary_text_color
                          : Colors.grey.withOpacity(0.2))),
              focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                      width: onlyLoginPage == true ? 1.5 : 0.5,
                      color: onlyLoginPage == true
                          ? primary_text_color
                          : Colors.grey.withOpacity(0.2))),
              errorBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(
                  Radius.circular(10.0),
                ),
                borderSide: BorderSide(
                    width: onlyLoginPage == true ? 1.5 : 0.5,
                    color: onlyLoginPage == true
                        ? primary_text_color
                        : Colors.grey.withOpacity(0.2)),
              ),
              filled: true,
              fillColor: onlyLoginPage == true
                  ? Colors.transparent
                  : fillColor ?? textFeildFillColor,
              errorText: errorMsg,
              errorStyle: AppStyle.errorStyle(context),
              hintText: hintText,
              hintStyle: AppStyle.bodyMedium(context).copyWith(
                color: reportFilter == true
                    ? text_color
                    : onlyLoginPage == true
                        ? primary_text_color
                        : gray_color,
                fontWeight: FontWeight.w400,
              )),
          validator: validator,
          cursorColor: cursorColor,
          onChanged: onChanged,
          focusNode: focusNode,
          controller: controller,
          style: AppStyle.bodySmall(context).copyWith(
              color: onlyLoginPage == true
                  ? primary_text_color
                  : isEnable || isEnable2
                      ? text_color
                      : gray_color,
              fontWeight: FontWeight.w400),
        ),
      ],
    );
  }
}
