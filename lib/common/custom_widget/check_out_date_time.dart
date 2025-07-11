import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/common/res/colors.dart';
import 'package:host_visitor_connect/common/res/styles.dart';
import 'package:host_visitor_connect/common/utils/utils.dart';
import 'package:host_visitor_connect/features/visitors/visitor_listing/ui/model/check_out_model.dart';

import 'fields/add_form_field.dart';

import 'package:intl/intl.dart';

class TimePicker extends StatefulWidget {
  final TimeOfDay initialTime;
  final ValueChanged<String>
      onTimeSelected; // Updated to accept a formatted time string

  const TimePicker({
    Key? key,
    required this.initialTime,
    required this.onTimeSelected,
  }) : super(key: key);

  @override
  _TimePickerState createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  late TimeOfDay _selectedTime;
  bool isSelected = false; // Track the selected state

  @override
  void initState() {
    super.initState();
    _selectedTime = widget.initialTime;
  }

  String formatTimeOfDay(TimeOfDay timeOfDay) {
    final now = DateTime.now();
    final dateTime = DateTime(
        now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
    final format = DateFormat('h:mm a'); // 12-hour format with AM/PM
    return format.format(dateTime);
  }

  void _selectTime(BuildContext context) async {
    // Show a modal bottom sheet with a CupertinoDatePicker
    TimeOfDay? picked = await showModalBottomSheet<TimeOfDay>(
      context: context,
      builder: (BuildContext builder) {
        return SizedBox(
          height: 300,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Select Time',
                      style: AppStyle.titleMedium(context)
                          .copyWith(fontWeight: FontWeight.w500),
                    ),
                    TextButton(
                      child: Text(
                        'Done',
                        style: AppStyle.titleMedium(context)
                            .copyWith(fontWeight: FontWeight.w500),
                      ),
                      onPressed: () {
                        // Format the selected time to 'h:mm a' for 12-hour clock format
                        String formattedTime = formatTimeOfDay(_selectedTime);
                        print("Done");
                        print(formattedTime);

                        // Update the CheckOutVisitor instance with the new time string
                        context.read<CheckOutVisitor>().checkOutTime =
                            formattedTime;

                        Navigator.of(context).pop(
                            _selectedTime); // Return selected time when "Done" is pressed
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.time,
                  initialDateTime: DateTime.now(),
                  onDateTimeChanged: (DateTime dateTime) {
                    // Update the selected time when the user changes it in the picker
                    setState(() {
                      _selectedTime = TimeOfDay.fromDateTime(dateTime);
                    });
                  },
                ),
              ),
            ],
          ),
        );
      },
    );

    // When the user selects a time and presses "Done", update the state and trigger the callback
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });

      // Format the new time as a string in 'HH:mm' format
      String formattedTime = formatTimeOfDay(_selectedTime);

      // Call the callback provided when creating the TimePicker to notify the parent widget
      widget.onTimeSelected(formattedTime);

      // Print the selected time to the console
      print('Selected Time: $formattedTime');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Convert TimeOfDay to a string format for display
    String selectedTimeString = formatTimeOfDay(_selectedTime);

    // GestureDetector to handle tap events on the widget
    return GestureDetector(
      onTap: () => _selectTime(context),
      child: AddFormField(
        showPrefix: true,
        isEnable: false,
        label: 'Checkout Time',
        prefixIcon: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: Row(
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.access_time_outlined, color: text_color),
              ),
              SizedBox(width: sizeWidth(context) / 35),
              Text(
                selectedTimeString,
                style: AppStyle.titleSmall(context).copyWith(color: text_color),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
