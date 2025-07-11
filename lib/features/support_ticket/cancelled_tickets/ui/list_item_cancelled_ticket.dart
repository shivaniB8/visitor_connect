import 'package:flutter/material.dart';
import 'package:host_visitor_connect/common/extensions/string_extensions.dart';
import 'package:host_visitor_connect/common/res/colors.dart';
import 'package:host_visitor_connect/common/res/styles.dart';
import 'package:host_visitor_connect/features/support_ticket/model/ticket.dart';

class ListItemCancelledTicket extends StatelessWidget {
  final Ticket? ticket;
  final int? ticketNo;
  const ListItemCancelledTicket({
    super.key,
    this.ticket,
    this.ticketNo,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
      ),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: background_grey_color,
            border: Border.all(color: background_dark_grey)),
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Sr No : $ticketNo'),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Created By',
                        style: AppStyle.bodyMedium(context).copyWith(
                          color: Colors.black.withOpacity(0.5),
                        ),
                      ),
                      Text(
                        capitalizedString(
                          ticket?.ticketCreatedByEmployeeValue ??
                              'Not Available',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Allocated To',
                        style: AppStyle.bodyMedium(context).copyWith(
                          color: Colors.black.withOpacity(0.5),
                        ),
                      ),
                      Text(
                        capitalizedString(
                          ticket?.ticketOwnerEmployeeValue ?? 'N/A',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Cancelled By',
                          style: AppStyle.bodyMedium(context).copyWith(
                            color: Colors.black.withOpacity(0.5),
                          ),
                        ),
                        Text(
                          capitalizedString(
                            ticket?.ticketCancelledByValue ?? 'Not Available',
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Expanded(
                  //   child: Button(
                  //     isRectangularBorder: true,
                  //     padding: const EdgeInsets.symmetric(
                  //         horizontal: 8, vertical: 0),
                  //     onPressed: () {},
                  //     text: 'Ticket History',
                  //     leading: const Icon(Icons.calendar_today_outlined),
                  //   ),
                  // ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          'Ticket No.',
                          style: AppStyle.titleExtraSmall(context).copyWith(
                            color: Colors.black.withOpacity(0.5),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 0.0, vertical: 5),
                              child:
                                  Text(ticket?.ticketNumber.toString() ?? '00'),
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
                      children: [
                        Text(
                          'Third Party Depend',
                          style: AppStyle.titleExtraSmall(context).copyWith(
                            color: Colors.black.withOpacity(0.5),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 0.0, vertical: 5),
                              child: Text(
                                ticket?.thirdPartyDependency == 1
                                    ? 'Yes'
                                    : "No",
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          'Submitted Date',
                          style: AppStyle.titleExtraSmall(context).copyWith(
                            color: Colors.black.withOpacity(0.5),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 0.0, vertical: 5),
                              child: Text(
                                timeStampToDateTime(ticket?.createdAt),
                              ),
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
                      children: [
                        Text(
                          'Submitted Time',
                          style: AppStyle.titleExtraSmall(context).copyWith(
                            color: Colors.black.withOpacity(0.5),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 0.0, vertical: 5),
                              child: Text(
                                timeStampToTime(ticket?.createdAt),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          'Cancelled Date',
                          style: AppStyle.titleExtraSmall(context).copyWith(
                            color: Colors.black.withOpacity(0.5),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 0.0, vertical: 5),
                              child:
                                  Text(timeStampToDateTime(ticket?.updatedAt)),
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
                      children: [
                        Text(
                          'Cancelled Time',
                          style: AppStyle.titleExtraSmall(context).copyWith(
                            color: Colors.black.withOpacity(0.5),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 0.0, vertical: 5),
                              child: Text(
                                timeStampToTime(ticket?.updatedAt),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
