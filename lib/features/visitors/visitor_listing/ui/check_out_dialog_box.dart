import 'package:flutter/material.dart';
import 'package:host_visitor_connect/common/blocs/state_events/ui_state.dart';
import 'package:host_visitor_connect/common/custom_widget/button.dart';
import 'package:host_visitor_connect/common/custom_widget/check_out_date_time.dart';
import 'package:host_visitor_connect/common/custom_widget/fields/date_time_field.dart';
import 'package:host_visitor_connect/common/custom_widget/initializer.dart';
import 'package:host_visitor_connect/common/custom_widget/title_bar_dialog.dart';
import 'package:host_visitor_connect/common/extensions/string_extensions.dart';
import 'package:host_visitor_connect/common/res/colors.dart';

import 'package:host_visitor_connect/features/visitors/visitor_listing/blocs/check_out_bloc.dart';
import 'package:host_visitor_connect/features/visitors/visitor_listing/ui/model/check_out_model.dart';
import 'package:intl/intl.dart';

import 'package:provider/provider.dart';
import '../../../../common/res/styles.dart';

class CheckOutDialogBox extends StatefulWidget {
  final bool? isProgress;
  final String? heading;
  final String? confirmationText;
  final Function()? onYesPressed;
  final Widget child;

  CheckOutDialogBox({
    Key? key,
    this.heading,
    this.confirmationText,
    this.onYesPressed,
    required this.child,
    this.isProgress,
  }) : super(key: key);

  @override
  State<CheckOutDialogBox> createState() => _CheckOutDialogBoxState();
}

class _CheckOutDialogBoxState extends State<CheckOutDialogBox> {
  DateTime? selectedDate;
  bool isSameDate(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  @override
  void initState() {
    // context.read<CheckOutVisitor>().checkOutDate = selectedDate.toString();
    super.initState();
  }

  String combinedDateTime = '';

  @override
  Widget build(BuildContext context) {
    return TitleBarDialog(
      dialogHeight: 0,
      headerTitle: widget.heading ?? '',
      bodyContent: IgnorePointer(
        ignoring: context.watch<CheckOutBloc>().state is Progress,
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                widget.confirmationText ?? '',
                style: AppStyle.bodyMedium(context),
              ),

              // White space
              const SizedBox(
                height: 15,
              ),
              passportExpiryDate(context),

              TimePicker(
                initialTime: TimeOfDay.now(),
                onTimeSelected: (formattedTime) {
                  // print('Selected Time: $formattedTime');
                  // Perform actions with the formatted time string
                },
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Initializer(child: widget.child),
                  const SizedBox(
                    width: 12,
                  ),
                  Button(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 45,
                    ),
                    text: 'No',
                    isRectangularBorder: true,
                    backgroundColor: disabled_color,
                    onPressed: () {
                      Navigator.pop(context); // Close the dialog
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget passportExpiryDate(BuildContext context) {
    return DateTimeField(
      maxYear: DateTime.now().add(const Duration(days: 1)),
      initialValue: DateTime.now(),

      setValue: (date) {
        setState(() {
          context.read<CheckOutVisitor>().checkOutDate =
              DateFormat('yyyy-MM-dd').format(date ?? DateTime.now());
          // date.toString();
        });
      },
      isEnabled: true, // Enable/disable based on your logic
      value: dateTimeFromString(
        context.read<CheckOutVisitor>().checkOutDate,
      ),
      isRequired: false,
      isReadOnly: false,
      label: 'Checkout Date',
    );
  }
}
