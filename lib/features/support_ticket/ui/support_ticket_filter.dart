import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:host_visitor_connect/common/custom_widget/button.dart';
import 'package:host_visitor_connect/common/custom_widget/fields/add_form_field.dart';
import 'package:host_visitor_connect/common/custom_widget/fields/date_filter_field.dart';
import 'package:host_visitor_connect/common/custom_widget/widget/filter_header.dart';
import 'package:host_visitor_connect/common/data/network/responses/key_value_response.dart';
import 'package:host_visitor_connect/common/res/colors.dart';
import 'package:host_visitor_connect/common/res/styles.dart';
import 'package:host_visitor_connect/common/utils/utils.dart';
import 'package:host_visitor_connect/features/support_ticket/cancelled_tickets/bloc/cancelled_ticket_bloc.dart';
import 'package:host_visitor_connect/features/support_ticket/closed_tickets/bloc/closed_ticket_bloc.dart';
import 'package:host_visitor_connect/features/support_ticket/new_tickets/bloc/new_ticket_bloc.dart';
import 'package:host_visitor_connect/features/support_ticket/open_ticket/bloc/open_ticket_bloc.dart';

class SupportTicketFilter extends StatefulWidget {
  final int? currentTab;
  const SupportTicketFilter({
    super.key,
    this.currentTab,
  });

  @override
  State<SupportTicketFilter> createState() => _SupportTicketFilterState();
}

class _SupportTicketFilterState extends State<SupportTicketFilter> {
  List<KeyValueResponse> ticketFor = [];
  List<KeyValueResponse> filters = [
    KeyValueResponse(value: 1, label: "Web Application"),
    KeyValueResponse(value: 2, label: "Mobile Applications"),
  ];
  KeyValueResponse? selectedFilters;

  String? submitDate;
  String? submitEndDate;

  String? tentativeDate;
  String? tentativeEndDate;

  String? closedDate;
  String? closedEndDate;

  String? cancelDate;
  String? cancelEndDate;

  String? ticketNumber;

  @override
  void initState() {
    super.initState();
  }

  void disposeFilters() {}

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        bottom: 0,
      ),
      height: MediaQuery.of(context).size.height * 0.6,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15.0),
          topRight: Radius.circular(15.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FilterHeader(
              title: "Support Ticket Filter",
              onTap: () => Navigator.pop(context),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Problem In',
              style: AppStyle.titleSmall(context)
                  .copyWith(color: filterTextColor)
                  .copyWith(fontWeight: FontWeight.w600),
            ),
            Wrap(
              spacing: 8.0,
              runSpacing: 4.0,
              children: filters.map(
                (filter) {
                  return FilterChip(
                    label: Text(filter.label ?? '',
                        style: AppStyle.bodyLarge(context).copyWith(
                            color: filterTextColor,
                            fontWeight: FontWeight.w400)),
                    selected: selectedFilters == filter,
                    backgroundColor: Colors.grey.withOpacity(0.2),
                    checkmarkColor: filterTextColor,
                    side:
                        const BorderSide(width: 0, color: filterInactiveColor),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    onSelected: (isSelected) {
                      setState(
                        () {
                          if (isSelected) {
                            selectedFilters = filter;
                          } else {
                            selectedFilters = null;
                          }
                        },
                      );
                    },
                  );
                },
              ).toList(),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Ticket Number',
              style: AppStyle.titleSmall(context)
                  .copyWith(color: filterTextColor)
                  .copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: EdgeInsets.only(right: sizeWidth(context) / 2),
              child: AddFormField(
                hintText: 'Enter Ticket number',
                onChanged: (ticketNo) {
                  ticketNumber = ticketNo;
                },
                keyboardType: TextInputType.number,
                fillColor: Colors.grey.withOpacity(0.2),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Submitted From',
                        style: AppStyle.titleSmall(context)
                            .copyWith(color: filterTextColor)
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      DateTimeFieldFilter(
                        fieldName: 'Submitted Date',
                        inputType: InputType.date,
                        hintText: 'Submitted Date',
                        onChanged: (startDate) {
                          if (startDate != null) {
                            submitDate = startDate.toString();
                          }
                          setState(() {});
                        },
                        style: AppStyle.bodyMedium(context),
                        lastSelectableDate: DateTime.now(),
                        decoration: form_field_input_decoration.copyWith(
                          hintStyle: AppStyle.bodyMedium(context).copyWith(
                            color: gray_color,
                            fontWeight: FontWeight.w400,
                          ),
                          fillColor: Colors.grey.withOpacity(0.2),
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 0.5,
                                color: Colors.grey.withOpacity(0.2)),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          hintText: 'Select',
                          isDense: true,
                          suffixIcon: const Icon(
                            Icons.date_range,
                            size: 25,
                            color: filterTextColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Submitted Till',
                        style: AppStyle.titleSmall(context)
                            .copyWith(color: filterTextColor)
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      DateTimeFieldFilter(
                        fieldName: 'Submitted Date',
                        inputType: InputType.date,
                        hintText: 'Submitted Date',
                        onChanged: (startDate) {
                          if (startDate != null) {
                            submitEndDate = startDate.toString();
                          }
                          setState(() {});
                        },
                        style: AppStyle.bodyMedium(context),
                        lastSelectableDate: DateTime.now(),
                        decoration: form_field_input_decoration.copyWith(
                          fillColor: Colors.grey.withOpacity(0.2),
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 0.5,
                                color: Colors.grey.withOpacity(0.2)),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          hintText: 'Select',
                          hintStyle: AppStyle.bodyMedium(context).copyWith(
                            color: gray_color,
                            fontWeight: FontWeight.w400,
                          ),
                          isDense: true,
                          suffixIcon: const Icon(
                            Icons.date_range,
                            size: 25,
                            color: filterTextColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (widget.currentTab == 1)
              const SizedBox(
                height: 20,
              ),
            if (widget.currentTab == 1)
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Tentative Closing From',
                          style: AppStyle.titleSmall(context)
                              .copyWith(color: filterTextColor)
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        DateTimeFieldFilter(
                          fieldName: 'Tentative Closing Date',
                          inputType: InputType.date,
                          hintText: 'Tentative Date',
                          onChanged: (startDate) {
                            if (startDate != null) {
                              tentativeDate = startDate.toString();
                            }
                            setState(() {});
                          },
                          style: AppStyle.bodyMedium(context),
                          lastSelectableDate: DateTime.now(),
                          decoration: form_field_input_decoration.copyWith(
                            hintStyle: AppStyle.bodyMedium(context).copyWith(
                              color: gray_color,
                              fontWeight: FontWeight.w400,
                            ),
                            fillColor: Colors.grey.withOpacity(0.2),
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 0.5,
                                  color: Colors.grey.withOpacity(0.2)),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            hintText: 'Select',
                            isDense: true,
                            suffixIcon: const Icon(
                              Icons.date_range,
                              size: 25,
                              color: filterTextColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Tentative Closing Till',
                          style: AppStyle.titleSmall(context)
                              .copyWith(color: filterTextColor)
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        DateTimeFieldFilter(
                          fieldName: 'Tentative Closing Till',
                          inputType: InputType.date,
                          hintText: 'Tentative Closing Till',
                          onChanged: (startDate) {
                            if (startDate != null) {
                              tentativeEndDate = startDate.toString();
                            }
                            setState(() {});
                          },
                          style: AppStyle.bodyMedium(context),
                          lastSelectableDate: DateTime.now(),
                          decoration: form_field_input_decoration.copyWith(
                            fillColor: Colors.grey.withOpacity(0.2),
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 0.5,
                                  color: Colors.grey.withOpacity(0.2)),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            hintText: 'Select',
                            hintStyle: AppStyle.bodyMedium(context).copyWith(
                              color: gray_color,
                              fontWeight: FontWeight.w400,
                            ),
                            isDense: true,
                            suffixIcon: const Icon(
                              Icons.date_range,
                              size: 25,
                              color: filterTextColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            if (widget.currentTab == 2)
              const SizedBox(
                height: 20,
              ),
            if (widget.currentTab == 2)
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Closed From',
                          style: AppStyle.titleSmall(context)
                              .copyWith(color: filterTextColor)
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        DateTimeFieldFilter(
                          fieldName: 'Closed Date',
                          inputType: InputType.date,
                          hintText: 'Closed Date',
                          onChanged: (startDate) {
                            if (startDate != null) {
                              closedDate = startDate.toString();
                            }
                            setState(() {});
                          },
                          style: AppStyle.bodyMedium(context),
                          lastSelectableDate: DateTime.now(),
                          decoration: form_field_input_decoration.copyWith(
                            hintStyle: AppStyle.bodyMedium(context).copyWith(
                              color: gray_color,
                              fontWeight: FontWeight.w400,
                            ),
                            fillColor: Colors.grey.withOpacity(0.2),
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 0.5,
                                  color: Colors.grey.withOpacity(0.2)),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            hintText: 'Select',
                            isDense: true,
                            suffixIcon: const Icon(
                              Icons.date_range,
                              size: 25,
                              color: filterTextColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Closed Till',
                          style: AppStyle.titleSmall(context)
                              .copyWith(color: filterTextColor)
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        DateTimeFieldFilter(
                          fieldName: 'Closed Till',
                          inputType: InputType.date,
                          hintText: 'Closed Till',
                          onChanged: (startDate) {
                            if (startDate != null) {
                              closedEndDate = startDate.toString();
                            }
                            setState(() {});
                          },
                          style: AppStyle.bodyMedium(context),
                          lastSelectableDate: DateTime.now(),
                          decoration: form_field_input_decoration.copyWith(
                            fillColor: Colors.grey.withOpacity(0.2),
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 0.5,
                                  color: Colors.grey.withOpacity(0.2)),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            hintText: 'Select',
                            hintStyle: AppStyle.bodyMedium(context).copyWith(
                              color: gray_color,
                              fontWeight: FontWeight.w400,
                            ),
                            isDense: true,
                            suffixIcon: const Icon(
                              Icons.date_range,
                              size: 25,
                              color: filterTextColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            if (widget.currentTab == 3)
              const SizedBox(
                height: 20,
              ),
            if (widget.currentTab == 3)
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Cancelled From',
                          style: AppStyle.titleSmall(context)
                              .copyWith(color: filterTextColor)
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        DateTimeFieldFilter(
                          fieldName: 'Cancelled Date',
                          inputType: InputType.date,
                          hintText: 'Cancelled Date',
                          onChanged: (startDate) {
                            if (startDate != null) {
                              cancelDate = startDate.toString();
                            }
                            setState(() {});
                          },
                          style: AppStyle.bodyMedium(context),
                          lastSelectableDate: DateTime.now(),
                          decoration: form_field_input_decoration.copyWith(
                            hintStyle: AppStyle.bodyMedium(context).copyWith(
                              color: gray_color,
                              fontWeight: FontWeight.w400,
                            ),
                            fillColor: Colors.grey.withOpacity(0.2),
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 0.5,
                                  color: Colors.grey.withOpacity(0.2)),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            hintText: 'Select',
                            isDense: true,
                            suffixIcon: const Icon(
                              Icons.date_range,
                              size: 25,
                              color: filterTextColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Cancelled Till',
                          style: AppStyle.titleSmall(context)
                              .copyWith(color: filterTextColor)
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        DateTimeFieldFilter(
                          fieldName: 'Cancelled Till',
                          inputType: InputType.date,
                          hintText: 'Cancelled Till',
                          onChanged: (startDate) {
                            if (startDate != null) {
                              cancelEndDate = startDate.toString();
                            }
                            setState(() {});
                          },
                          style: AppStyle.bodyMedium(context),
                          lastSelectableDate: DateTime.now(),
                          decoration: form_field_input_decoration.copyWith(
                            fillColor: Colors.grey.withOpacity(0.2),
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 0.5,
                                  color: Colors.grey.withOpacity(0.2)),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            hintText: 'Select',
                            hintStyle: AppStyle.bodyMedium(context).copyWith(
                              color: gray_color,
                              fontWeight: FontWeight.w400,
                            ),
                            isDense: true,
                            suffixIcon: const Icon(
                              Icons.date_range,
                              size: 25,
                              color: filterTextColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: Button(
                    isRectangularBorder: true,
                    buttonType: ButtonType.stroked,
                    child: Text(
                      'Clear All',
                      style: AppStyle.buttonStyle(context)
                          .copyWith(color: profileTextColor),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                      if (widget.currentTab == 0) {
                        context.read<NewTicketBloc>().getTickets(
                              status: 1,
                            );
                      }
                      if (widget.currentTab == 1) {
                        context.read<OpenTicketBloc>().getTickets(
                              status: 2,
                            );
                      }
                      if (widget.currentTab == 2) {
                        context.read<ClosedTicketBloc>().getTickets(
                              status: 3,
                            );
                      }
                      if (widget.currentTab == 3) {
                        context.read<CancelledTicketBloc>().getTickets(
                              status: 5,
                            );
                      }
                    },
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Button(
                    isRectangularBorder: true,
                    backgroundColor: profileTextColor,
                    onPressed: () {
                      Navigator.of(context).pop();
                      if (widget.currentTab == 0) {
                        context.read<NewTicketBloc>().getTickets(
                              status: 1,
                              sa5: selectedFilters?.value,
                              submittedTill: submitDate,
                              submittedFrom: submitEndDate,
                            );
                      }
                      if (widget.currentTab == 1) {
                        context.read<OpenTicketBloc>().getTickets(
                              status: 2,
                              sa5: selectedFilters?.value,
                              submittedFrom: submitDate,
                              submittedTill: submitEndDate,
                              tentativeDateFrom: tentativeDate,
                              tentativeDateTill: tentativeEndDate,
                            );
                      }
                      if (widget.currentTab == 2) {
                        context.read<ClosedTicketBloc>().getTickets(
                              status: 3,
                              sa5: selectedFilters?.value,
                              submittedFrom: submitDate,
                              submittedTill: submitEndDate,
                              closedDateFrom: closedDate,
                              closedDateTill: closedEndDate,
                            );
                      }
                      if (widget.currentTab == 3) {
                        context.read<CancelledTicketBloc>().getTickets(
                              status: 5,
                              sa5: selectedFilters?.value,
                              submittedFrom: submitDate,
                              submittedTill: submitEndDate,
                              cancelledDateTill: cancelDate,
                              cancelledDateFrom: cancelEndDate,
                            );
                      }
                    },
                    child: Text('Apply', style: AppStyle.buttonStyle(context)),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
