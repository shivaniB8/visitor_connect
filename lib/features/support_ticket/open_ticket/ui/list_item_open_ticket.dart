import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/common/custom_widget/button.dart';
import 'package:host_visitor_connect/common/custom_widget/dots_progress_button.dart';
import 'package:host_visitor_connect/common/custom_widget/fields/add_form_field.dart';
import 'package:host_visitor_connect/common/extensions/string_extensions.dart';
import 'package:host_visitor_connect/common/res/colors.dart';
import 'package:host_visitor_connect/common/res/paths.dart';
import 'package:host_visitor_connect/common/res/styles.dart';
import 'package:host_visitor_connect/common/utils/route_generator.dart';
import 'package:host_visitor_connect/common/utils/utils.dart';
import 'package:host_visitor_connect/features/support_ticket/bloc/cancel_ticket_bloc.dart';
import 'package:host_visitor_connect/features/support_ticket/bloc/ticket_communication_bloc.dart';
import 'package:host_visitor_connect/features/support_ticket/bloc/ticket_history_bloc.dart';
import 'package:host_visitor_connect/features/support_ticket/model/ticket.dart';
import 'package:host_visitor_connect/features/support_ticket/open_ticket/bloc/open_ticket_bloc.dart';
import 'package:host_visitor_connect/features/support_ticket/ui/cancel_ticket_builder.dart';
import 'package:host_visitor_connect/features/support_ticket/ui/ticket_history_screen.dart';
import 'package:provider/provider.dart';

class ListItemOpenTicket extends StatefulWidget {
  final Ticket? ticket;
  final int? ticketNo;

  const ListItemOpenTicket({
    super.key,
    this.ticket,
    this.ticketNo,
  });

  @override
  State<ListItemOpenTicket> createState() => _ListItemOpenTicketState();
}

class _ListItemOpenTicketState extends State<ListItemOpenTicket> {
  String? message;
  bool? showErrorMsg = false;

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
              Text('Sr No : ${widget.ticketNo}'),
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
                          'Created By',
                          style: AppStyle.bodyMedium(context).copyWith(
                            color: Colors.black.withOpacity(0.5),
                          ),
                        ),
                        Text(
                          capitalizedString(
                            widget.ticket?.ticketCreatedByEmployeeValue ??
                                'N/A',
                          ),
                          maxLines: 1,
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
                          'Allocated To',
                          style: AppStyle.bodyMedium(context).copyWith(
                            color: Colors.black.withOpacity(0.5),
                          ),
                        ),
                        Text(
                          maxLines: 1,
                          capitalizedString(
                            widget.ticket?.ticketOwnerEmployeeValue ?? 'N/A',
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
                              child: Text(
                                widget.ticket?.ticketNumber.toString() ?? '00',
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
                          'Call in Pin.',
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
                                  widget.ticket?.callinPin.toString() ?? '00'),
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
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: Button(
                      style: AppStyle.bodyMedium(context).copyWith(
                        color: Colors.white,
                      ),
                      isRectangularBorder: true,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 0),
                      onPressed: () {
                        Navigator.of(context).push(goToRoute(MultiProvider(
                          providers: [
                            BlocProvider(
                              create: (_) => TicketHistoryBloc(),
                            ),
                            BlocProvider(
                              create: (_) => TicketCommunicationBloc(),
                            ),
                          ],
                          child: TicketHistoryScreen(
                            ticket: widget.ticket,
                            sa1: widget.ticket?.ticketNumber,
                          ),
                        )));
                        // showDialog(
                        //   context: context,
                        //   builder: (_) {
                        //     return MultiProvider(
                        //       providers: [
                        //         BlocProvider(
                        //           create: (_) => TicketHistoryBloc(),
                        //         ),
                        //         BlocProvider(
                        //           create: (_) => TicketCommunicationBloc(),
                        //         ),
                        //       ],
                        //       child: TicketHistoryScreen(
                        //         ticket: widget.ticket,
                        //         sa1: widget.ticket?.ticketNumber,
                        //       ),
                        //     );
                        //   },
                        // );
                      },
                      text: 'Ticket History',
                      leading: const Icon(Icons.calendar_today_outlined),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Button(
                      style: AppStyle.bodyMedium(context).copyWith(
                        color: Colors.white,
                      ),
                      isRectangularBorder: true,
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 0),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (_) {
                            return cancelTicketDialog(
                              showError: (value) {
                                if (value) {
                                  setState(() {
                                    showErrorMsg = true;
                                  });
                                }
                              },
                            );
                          },
                        );
                      },
                      text: 'Cancel Ticket',
                      leading: const Icon(Icons.calendar_today_outlined),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              submittedDateRow(context),
              const SizedBox(
                height: 10,
              ),
              tentativeClosingRow(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget cancelTicketDialog({
    Function(bool)? showError,
  }) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => CancelTicketBloc(),
        ),
        BlocProvider.value(
          value: context.read<OpenTicketBloc>(),
        ),
      ],
      child: StatefulBuilder(builder: (context, dialogState) {
        return Dialog(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15.0,
              vertical: 10,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Color(0xffFFD1D3),
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(8),
                  child: Image.asset(
                    '$icons_path/ticket.png',
                    height: sizeHeight(context) / 18,
                  ),
                ),
                SizedBox(height: sizeHeight(context) / 50),
                Text(
                  'Cancel Ticket',
                  style: AppStyle.headlineSmall(context).copyWith(
                      fontWeight: FontWeight.w700, color: errorDiloagTitle),
                ),
                SizedBox(height: sizeHeight(context) / 80),
                Text(
                  "Are you sure, you want to cancel ticket.",
                  style: AppStyle.bodyMedium(context)
                      .copyWith(color: errorDiloagSubtitle),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: sizeHeight(context) / 50,
                ),
                AddFormField(
                  padding: const EdgeInsets.only(top: 5, bottom: 5),
                  maxLines: 3,
                  label: 'Message',
                  hintText: 'Write reason to cancel ticket',
                  onChanged: (value) {
                    message = value;
                  },
                ),
                if (showErrorMsg ?? false)
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Please type reason',
                      style: AppStyle.errorStyle(context),
                    ),
                  ),
                SizedBox(
                  height: sizeHeight(context) / 70,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: DotsProgressButton(
                        text: 'Cancel',
                        buttonBackgroundColor: disabled_color,
                        isRectangularBorder: true,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: CancelTicketBuilder(
                        onSuccess: () {
                          context.read<OpenTicketBloc>().getTickets(status: 2);
                          Navigator.of(context).pop();
                        },
                        onCancelTicket: () {
                          if (!(message.isNullOrEmpty())) {
                            context.read<CancelTicketBloc>().cancelTicket(
                                  sa1: widget.ticket?.ticketNumber,
                                  sb5: message,
                                );
                          } else {
                            dialogState(() {
                              showError?.call(true);
                            });
                          }
                        },
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget submittedDateRow(BuildContext context) {
    return Row(
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
                      timeStampToDateTime(widget.ticket?.createdAt),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          width: 10,
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
                      timeStampToTime(widget.ticket?.createdAt),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          width: 10,
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
                      widget.ticket?.thirdPartyDependency == 1 ? 'Yes' : "No",
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget tentativeClosingRow(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Column(
            children: [
              Text(
                'Tentative Closing',
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
                      timeStampToDateTime(widget.ticket?.tentativeClosingDate),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Column(
            children: [
              Text(
                'Opend By',
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
                      capitalizedString(
                          widget.ticket?.ticketOpenedByTicketValue ?? 'N/A'),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
