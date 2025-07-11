import 'package:flutter/material.dart';
import 'package:host_visitor_connect/common/extensions/string_extensions.dart';
import 'package:host_visitor_connect/common/res/colors.dart';
import 'package:host_visitor_connect/common/res/styles.dart';

import '../data/network/responses/key_value_response.dart';

class FormDropDownWidget extends StatefulWidget {
  final Function(KeyValueResponse data) onTap;
  final String? dropdownFirstItemName;
  final bool? isFromBranch;
  final List<KeyValueResponse> titles;
  final String? title;
  final bool isItEnabled;
  final bool? isHeight;
  final String? errorMessage;
  final bool? isRequired;
  final bool isNull;
  final Function()? removeValue;
  final Color? fillColor;

  const FormDropDownWidget({
    super.key,
    required this.titles,
    required this.onTap,
    this.isItEnabled = true,
    this.title = '',
    this.isHeight,
    this.dropdownFirstItemName,
    this.errorMessage,
    this.isRequired = false,
    this.isNull = false,
    this.removeValue,
    this.isFromBranch,
    this.fillColor = textFeildFillColor,
  });

  @override
  State<FormDropDownWidget> createState() => _FormDropDownWidgetState();
}

class _FormDropDownWidgetState extends State<FormDropDownWidget> {
  String defaultValue = "";
  String? hintText;
  TextEditingController? searchController;
  @override
  void initState() {
    super.initState();

    defaultValue = widget.title ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: appSize(context: context, unit: 10) / 4.5,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 14),
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: widget.fillColor,
            border: Border.all(color: Colors.grey.withOpacity(0.2)),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      padding: const EdgeInsets.all(0),
                      alignment: Alignment.centerLeft,
                      borderRadius: BorderRadius.circular(10),
                      menuMaxHeight: 300,
                      isDense: true,
                      iconEnabledColor: Colors.transparent,
                      iconDisabledColor: Colors.transparent,
                      value: defaultValue.toLowerCase(),
                      style: text_style_para1.copyWith(color: text_color),
                      icon: const Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.black,
                      ),
                      items: [
                        DropdownMenuItem(
                          onTap: widget.removeValue,
                          value: "",
                          child: Text(
                            widget.dropdownFirstItemName ?? "Choose from below",
                            style: AppStyle.bodySmall(context).copyWith(
                              color: gray_color,
                            ),
                          ),
                        ),
                        ...widget.titles.map<DropdownMenuItem<String>>(
                          (data) {
                            return DropdownMenuItem(
                              onTap: () {
                                widget.onTap(data);
                                defaultValue = data.value.toString();
                              },
                              value: data.label.toString().toLowerCase(),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4.0),
                                child: Text(
                                  capitalizedString(data.label.toString()),
                                  style: AppStyle.bodySmall(context).copyWith(
                                    color: widget.isItEnabled
                                        ? text_color
                                        : gray_color,
                                  ),
                                ),
                              ),
                            );
                          },
                        ).toList(),
                      ],
                      onChanged: (String? selectedValue) {
                        setState(() {
                          defaultValue = selectedValue!;
                        });
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10),
        // Error message display
        ((widget.isRequired ?? false) && (widget.isNull))
            ? Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text(
                  widget.errorMessage ?? "",
                  style: AppStyle.errorStyle(context),
                ),
              )
            : SizedBox(), // Use SizedBox() instead of const SizedBox() for conditional rendering
      ],
    );
  }
}
