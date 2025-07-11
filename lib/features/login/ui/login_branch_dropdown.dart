import 'package:flutter/material.dart';
import 'package:host_visitor_connect/common/data/network/responses/key_value_response.dart';
import 'package:host_visitor_connect/common/extensions/string_extensions.dart';
import 'package:host_visitor_connect/common/res/colors.dart';
import 'package:host_visitor_connect/common/res/styles.dart';

class LoginFormDropDownWidget extends StatefulWidget {
  final Function(KeyValueResponse data) onTap;
  final String? dropdownFirstItemName;
  final bool? isFromBranch;
  final List<KeyValueResponse> titles;
  final KeyValueResponse? title;
  final bool isItEnabled;
  final bool? isHeight;
  final String? errorMessage;
  final bool? isRequired;
  final bool isNull;
  final Function()? removeValue;

  const LoginFormDropDownWidget({
    super.key,
    required this.titles,
    required this.onTap,
    this.isItEnabled = true,
    this.title,
    this.isHeight,
    this.dropdownFirstItemName,
    this.errorMessage,
    this.isRequired = false,
    this.isNull = false,
    this.removeValue,
    this.isFromBranch,
  });

  @override
  State<LoginFormDropDownWidget> createState() =>
      _LoginFormDropDownWidgetState();
}

class _LoginFormDropDownWidgetState extends State<LoginFormDropDownWidget> {
  KeyValueResponse? defaultValue;

  @override
  void initState() {
    super.initState();

    defaultValue = widget.title;
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
            color: Colors.white,
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
                    child: DropdownButton<KeyValueResponse>(
                      padding: const EdgeInsets.all(0),
                      alignment: Alignment.centerLeft,
                      borderRadius: BorderRadius.circular(10),
                      menuMaxHeight: 300,
                      isDense: true,
                      hint: Text(
                        capitalizedString(
                          defaultValue?.label ?? 'choose from below',
                        ),
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: (widget.isItEnabled)
                                ? Colors.black
                                : Colors.grey),
                      ),

                      iconEnabledColor: Colors.transparent,
                      iconDisabledColor: Colors.transparent,
                      value: defaultValue,
                      style: text_style_para1.copyWith(color: text_color),
                      icon: const Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.black,
                      ),
                      // icon: const SizedBox(),
                      items:
                          widget.titles.map<DropdownMenuItem<KeyValueResponse>>(
                        (data) {
                          return DropdownMenuItem(
                            onTap: () {
                              widget.onTap(data);
                              defaultValue = data;
                            },
                            value: data,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              child: Text(
                                capitalizedString(data.label.toString()),
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: (widget.isItEnabled)
                                        ? Colors.black
                                        : Colors.grey),
                              ),
                            ),
                          );
                        },
                      ).toList(),
                      onChanged: (KeyValueResponse? selectedValue) {
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
        const SizedBox(
          height: 10,
        ),
        ((widget.isRequired ?? false) && (widget.isNull))
            ? Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text(
                  widget.errorMessage ?? "",
                  style: const TextStyle(color: Colors.red, fontSize: 12),
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}
