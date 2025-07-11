import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:host_visitor_connect/common/res/colors.dart';
import 'package:host_visitor_connect/common/res/styles.dart';
import 'package:intl/intl.dart';

import 'add_form_field.dart';

class DateTimeField extends StatefulWidget {
  final String? label;
  final DateTime? maxYear;
  final DateTime? minYear;
  final DateTime? value;
  final bool isRequired;
  final bool isEnabled;
  final Function(DateTime?)? setValue;
  final DateTime? initialValue;
  final bool isReadOnly;
  final bool? isDOB;

  const DateTimeField({
    Key? key,
    this.label,
    this.value,
    this.isRequired = false,
    this.isEnabled = true,
    this.setValue,
    this.initialValue,
    this.maxYear,
    this.minYear,
    required this.isReadOnly,
    this.isDOB = false,
  }) : super(key: key);

  @override
  State<DateTimeField> createState() => _DateTimeFieldState();
}

class _DateTimeFieldState extends State<DateTimeField> {
  final TextEditingController _controller = TextEditingController();
  DateTime? selectedDate;
  DateTime defaultDate = DateTime.now().subtract(const Duration(days: 1));
  DateTime? dateOfBirth = DateTime.now();

  @override
  void initState() {
    super.initState();
    selectedDate = widget.initialValue;
    _setInitialValue();
  }

  void _setInitialValue() {
    if (widget.initialValue != null) {
      String formattedDate =
          DateFormat('dd-MM-yyyy').format(widget.initialValue!);
      _controller.text = formattedDate;
    } else {
      _controller.text = "Select";
    }
  }

  void _updateDate(DateTime? date) {
    if (date != null) {
      String formattedDate = DateFormat('dd-MM-yyyy').format(date);
      _controller.text = formattedDate;
      widget.setValue?.call(date);
      setState(() {
        selectedDate = date;
      });
    }
  }

  bool isBeforeDate(DateTime date1, DateTime date2) {
    if (date1.year != date2.year) {
      return date1.year > date2.year;
    } else if (date1.month != date2.month) {
      return date1.month > date2.month;
    } else {
      return date1.day > date2.day;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.isEnabled
          ? () => showCupertinoModalPopup(
                context: context,
                builder: (_) => Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                    ),
                    height: appSize(context: context, unit: 11),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Material(
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 15.0),
                            child: GestureDetector(
                              onTap: () {
                                widget.setValue?.call(dateOfBirth);
                                if (widget.initialValue == null) {
                                  _controller.text =
                                      "${DateTime.now().day.toString().padLeft(2, '0')}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().year}";
                                }
                                setState(() {});
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                'Done',
                                style: AppStyle.titleMedium(context)
                                    .copyWith(fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                          ),
                          height: appSize(context: context, unit: 8),
                          child: CupertinoTheme(
                            data: CupertinoThemeData(
                              textTheme: CupertinoTextThemeData(
                                  dateTimePickerTextStyle:
                                      AppStyle.titleMedium(context)
                                          .copyWith(color: text_color),
                                  pickerTextStyle:
                                      AppStyle.titleMedium(context)),
                            ),
                            child: CupertinoDatePicker(
                              initialDateTime: widget.initialValue != null
                                  ? DateTime(
                                      widget.initialValue!.year,
                                      widget.initialValue!.month,
                                      widget.initialValue!.day,
                                    )
                                  : DateTime(DateTime.now().year,
                                      DateTime.now().month, DateTime.now().day),
                              // minimumYear: 1850 ?? 1850,
                              maximumDate: widget.maxYear,
                              minimumDate:
                                  widget.minYear ?? DateTime(1850, 1, 1),
                              // maximumYear: 2009 ?? DateTime.now().year,
                              backgroundColor: Colors.white,
                              use24hFormat: true,
                              mode: CupertinoDatePickerMode.date,
                              dateOrder: DatePickerDateOrder.dmy,
                              onDateTimeChanged: (DateTime value) {
                                dateOfBirth = value;
                                _updateDate(value);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
          : null,
      child: AddFormField(
        showPrefix: true,
        isEnable2:
            (!isBeforeDate(DateTime.now(), selectedDate ?? defaultDate) &&
                    widget.isEnabled) ||
                (widget.isDOB == true && selectedDate != null) ||
                _controller.text != "Select",
        isEnable: false,
        controller: _controller,
        prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Icon(
              Icons.calendar_month,
              color:
                  (!isBeforeDate(DateTime.now(), selectedDate ?? defaultDate) &&
                              widget.isEnabled) ||
                          (widget.isDOB == true && selectedDate != null) ||
                          _controller.text != "Select"
                      ? Colors.black
                      : gray_color,
            )),
        isRequired: widget.isRequired,
        label: widget.label,
      ),
    );
  }
}
