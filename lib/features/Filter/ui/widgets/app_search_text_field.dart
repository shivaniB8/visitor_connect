import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:host_visitor_connect/common/res/styles.dart';

class AppSearchTextField extends StatelessWidget {
  const AppSearchTextField({
    super.key,
    this.leading,
    required this.hintText,
    required this.onChanged,
    this.inputFormatters,
    this.keyboardType = TextInputType.text,
    this.textFieldHeight,
    this.maxLines = 1,
    this.textInputAction,
    this.controller,
    this.obscureText = false,
    this.suffixIcon,
    this.maxLength,
    this.textCapitalization = TextCapitalization.words,
    this.validator,
    this.enabled = true,
  });

  final String hintText;
  final bool enabled;
  final bool obscureText;
  final Widget? leading;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final Function(String) onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final double? textFieldHeight;
  final int? maxLines;
  final int? maxLength;
  final TextInputAction? textInputAction;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextCapitalization textCapitalization;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: appSize(context: context, unit: 30) / 10,
            padding: const EdgeInsets.symmetric(horizontal: 2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: Border.all(width: 1.0, color: Colors.black),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                leading != null ? leading! : Container(),
                Expanded(
                  child: TextFormField(
                    enabled: enabled,
                    validator: validator,
                    obscureText: obscureText,
                    controller: controller,
                    maxLines: maxLines,
                    textAlign: TextAlign.start,
                    keyboardType: keyboardType,
                    textAlignVertical: TextAlignVertical.center,
                    textCapitalization: textCapitalization,
                    onChanged: onChanged,
                    inputFormatters: inputFormatters,
                    textInputAction: textInputAction,
                    style: AppStyle.titleMedium(context),
                    decoration: InputDecoration(
                      suffixIcon: suffixIcon,
                      isCollapsed: true,
                      hintText: hintText,
                      hintStyle: AppStyle.titleMedium(context),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.fromLTRB(6, 0, 6, 2),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
