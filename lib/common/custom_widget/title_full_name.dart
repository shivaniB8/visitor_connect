import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:host_visitor_connect/common/custom_widget/fields/add_form_field.dart';
import 'package:host_visitor_connect/common/extensions/string_extensions.dart';
import 'package:host_visitor_connect/common/res/colors.dart';
import 'package:host_visitor_connect/common/res/styles.dart';
import '../data/network/responses/key_value_response.dart';
import 'fields/form_field_label.dart';

// ignore: must_be_immutable
class TitleAndFirstNameWidget extends StatefulWidget {
  final Function(KeyValueResponse data) onTap;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final List<KeyValueResponse>? titles;
  final bool? isUpdate;
  final bool? isFirstNameNotValid;
  int? title;
  final bool isItEnabled;
  final String? initialValue;
  final TextEditingController? firstNameController;
  final FocusNode? focusNode;
  final bool? isTitleNull;
  final String? state;
  final bool? isEnable;

  TitleAndFirstNameWidget({
    super.key,
    this.titles,
    this.isUpdate,
    required this.isItEnabled,
    this.title,
    this.initialValue,
    this.firstNameController,
    required this.onTap,
    this.isTitleNull,
    this.onChanged,
    this.validator,
    this.focusNode,
    this.isFirstNameNotValid,
    this.state,
    this.isEnable,
  });

  @override
  State<TitleAndFirstNameWidget> createState() =>
      _TitleAndFirstNameWidgetState();
}

class _TitleAndFirstNameWidgetState extends State<TitleAndFirstNameWidget> {
  int defaultValue = 0;

  @override
  void initState() {
    super.initState();
    defaultValue = widget.title ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width / 5,
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FormFieldLabel(
                    label: 'Title',
                    isRequired: true,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 15),
            const Column(
              children: [
                FormFieldLabel(
                  label: 'Full Name',
                  isRequired: true,
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            )
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: kMinInteractiveDimension,
              width: MediaQuery.of(context).size.width / 5,
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: textFeildFillColor,
                  border: Border.all(
                      color: Colors.grey.withOpacity(0.2), width: 0.5),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<int>(
                        isDense: true,
                        borderRadius: BorderRadius.circular(10),
                        menuMaxHeight: 300,
                        // alignment: Alignment.center,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        value: defaultValue,
                        iconEnabledColor:
                            widget.isItEnabled ? Colors.black : Colors.grey,
                        iconDisabledColor:
                            widget.isItEnabled ? Colors.black : Colors.grey,
                        items: [
                          DropdownMenuItem(
                            value: 0,
                            child: Text(
                              "Title",
                              style: AppStyle.bodySmall(context)
                                  .copyWith(color: gray_color),
                            ),
                          ),
                          ...(widget.titles ?? []).map((value) {
                            return DropdownMenuItem<int>(
                              onTap: () {
                                widget.onTap(value);
                              },
                              value: value.value,
                              child: Text(
                                value.label ?? "",
                                style: AppStyle.bodySmall(context).copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: widget.isItEnabled
                                        ? Colors.black
                                        : gray_color),
                              ),
                            );
                          }).toList()
                        ],
                        onChanged: (int? selectedValue) {
                          setState(() {
                            defaultValue = selectedValue!;
                          });
                        },
                      ),
                    )),
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: AddFormField(
                maxLines: 1,
                fillColor: textFeildFillColor,
                onChanged: widget.onChanged,
                isEnable: widget.isEnable ?? true,
                isRequired: true,
                validator: widget.validator,
                controller: widget.firstNameController,
                initialValue: widget.initialValue,
                hintText: "Enter Your Full Name",
                // label: 'Full Name',
                inputFormatters: [
                  FilteringTextInputFormatter.deny(RegExp(r'[0-9]')),
                  FilteringTextInputFormatter.deny(
                      RegExp(r'[!@#%^&*()<>?/"+,.=_]')),
                  FilteringTextInputFormatter.deny(RegExp(r'^\s*')),
                ],
              ),
            ),
          ],
        ),
        Row(
          children: [
            (widget.isTitleNull ?? false)
                ? SizedBox(
                    width: MediaQuery.of(context).size.width / 5,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: Text(
                        'Required',
                        style: AppStyle.errorStyle(context),
                      ),
                    ),
                  )
                : SizedBox(
                    width: MediaQuery.of(context).size.width / 5,
                  ),
            const SizedBox(
              width: 15,
            ),
            (!(widget.state.isNullOrEmpty()) ||
                    (widget.isFirstNameNotValid ?? false))
                ? SizedBox(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: Text(
                        widget.state.isNullOrEmpty()
                            ? 'Please enter Full Name'
                            : widget.state ?? '',
                        style: AppStyle.errorStyle(context),
                      ),
                    ),
                  )
                : SizedBox(
                    width: MediaQuery.of(context).size.width / 5,
                  ),
          ],
        )
      ],
    );
  }
}
