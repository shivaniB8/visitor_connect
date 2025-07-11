import 'package:flutter/material.dart';
import 'package:host_visitor_connect/common/data/network/responses/key_value_response.dart';
import 'package:host_visitor_connect/common/extensions/string_extensions.dart';
import 'package:host_visitor_connect/common/res/styles.dart';

class SingleSelectionDropdown extends StatefulWidget {
  final Function(KeyValueResponse data) onTap;
  final String? dropdownFirstItemName;
  final List<KeyValueResponse> list;
  final String? initialValue;
  final bool isItEnabled;
  final bool? isHeight;
  final String? errorMessage;
  final bool? isRequired;
  final bool isNull;
  final Function()? removeValue;

  const SingleSelectionDropdown({
    super.key,
    required this.list,
    required this.onTap,
    this.isItEnabled = true,
    this.initialValue = '',
    this.isHeight,
    this.dropdownFirstItemName,
    this.errorMessage,
    this.isRequired = false,
    this.isNull = false,
    this.removeValue,
  });

  @override
  State<SingleSelectionDropdown> createState() =>
      _SingleSelectionDropdownState();
}

class _SingleSelectionDropdownState extends State<SingleSelectionDropdown> {
  String defaultValue = "";

  @override
  void initState() {
    super.initState();

    defaultValue = widget.initialValue ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: (widget.isHeight ?? false)
          ? MediaQuery.of(context).size.width / 5
          : MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
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
                      child: DropdownButton(
                        elevation: 0,
                        // dropdownColor: Colors.white,
                        padding: const EdgeInsets.all(0),
                        alignment: Alignment.centerLeft,
                        borderRadius: BorderRadius.circular(10),
                        menuMaxHeight: 300,
                        isDense: true,
                        iconEnabledColor: Colors.transparent,
                        iconDisabledColor: Colors.transparent,
                        value: defaultValue.toLowerCase(),
                        icon: const Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.black,
                        ),
                        // icon: const SizedBox(),
                        items: [
                          DropdownMenuItem(
                            onTap: widget.removeValue,
                            value: "",
                            child: Text(
                              widget.dropdownFirstItemName ??
                                  "Choose from below",
                              style: const TextStyle(fontSize: 14),
                            ),
                          ),
                          ...widget.list.map<DropdownMenuItem<String>>(
                            (data) {
                              return DropdownMenuItem(
                                onTap: () {
                                  widget.onTap(data);
                                  defaultValue = data.value.toString();
                                },
                                value: data.label.toString().toLowerCase(),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 4.0),
                                  child: Text(
                                    capitalizedString(data.label.toString()),
                                    style: text_style_basic.copyWith(
                                      color: widget.isItEnabled
                                          ? Colors.black
                                          : Colors.grey,
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
      ),
    );
  }
}
