import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/common/custom_widget/button.dart';
import 'package:host_visitor_connect/common/custom_widget/dots_progress_button.dart';
import 'package:host_visitor_connect/common/custom_widget/fields/add_form_field.dart';
import 'package:host_visitor_connect/common/extensions/string_extensions.dart';
import 'package:host_visitor_connect/common/res/colors.dart';
import 'package:host_visitor_connect/common/res/paths.dart';
import 'package:host_visitor_connect/common/res/styles.dart';
import 'package:host_visitor_connect/common/utils/utils.dart';
import 'package:host_visitor_connect/features/support_ticket/bloc/cancel_ticket_bloc.dart';
import 'package:host_visitor_connect/features/support_ticket/bloc/ticket_communication_bloc.dart';
import 'package:host_visitor_connect/features/support_ticket/bloc/ticket_history_bloc.dart';
import 'package:host_visitor_connect/features/support_ticket/model/ticket.dart';
import 'package:host_visitor_connect/features/support_ticket/new_tickets/bloc/new_ticket_bloc.dart';
import 'package:host_visitor_connect/features/support_ticket/ui/cancel_ticket_builder.dart';
import 'package:host_visitor_connect/features/support_ticket/ui/ticket_history_screen.dart';
import 'package:provider/provider.dart';

class ListItemNewTicket extends StatefulWidget {
  final Ticket? ticket;
  final int? ticketNo;

  const ListItemNewTicket({
    super.key,
    this.ticket,
    this.ticketNo,
  });

  @override
  State<ListItemNewTicket> createState() => _ListItemNewTicketState();
}

class _ListItemNewTicketState extends State<ListItemNewTicket> {
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
            borderRadius: BorderRadius.circular(10),
            color: card_background_grey_color,
            border: Border.all(color: Colors.grey)),
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Sr No. ${widget.ticketNo}',
                    style: AppStyle.titleLarge(context).copyWith(
                        fontSize: appSize(context: context, unit: 10) / 16),
                  ),
                  const Spacer(),
                  Icon(
                    Icons.more_horiz,
                    color: Colors.black.withOpacity(0.5),
                  )
                ],
              ),
              Row(
                children: [
                  CircleAvatar(
                    child: Image.asset('$images_path/indian_visitor.png'),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Created By',
                        style: AppStyle.bodyMedium(context).copyWith(
                            color: Colors.black.withOpacity(0.5),
                            fontSize: appSize(context: context, unit: 10) / 17),
                      ),
                      Text(
                        capitalizedString(
                          widget.ticket?.ticketCreatedByEmployeeValue ??
                              'Not Available',
                        ),
                        style: AppStyle.bodyMedium(context).copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: appSize(context: context, unit: 10) / 17),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _viewInfoBox("Ticket No.",
                      widget.ticket?.ticketNumber.toString() ?? '00'),
                  const SizedBox(width: 12),
                  _viewInfoBox("Call In Pin.",
                      widget.ticket?.callinPin.toString() ?? '00'),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
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
                        showDialog(
                          context: context,
                          builder: (_) {
                            return MultiProvider(
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
                            );
                          },
                        );
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
                      style: AppStyle.bodyMedium(context).copyWith(
                        color: Colors.white,
                      ),
                      text: 'Cancel Ticket',
                      leading: const Icon(Icons.calendar_today_outlined),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _viewInfoBox("Submitted Date",
                      timeStampToDateTime(widget.ticket?.createdAt)),
                  const SizedBox(width: 12),
                  _viewInfoBox("Submitted Time",
                      timeStampToTime(widget.ticket?.createdAt)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  _viewInfoBox(String title, String text) => Expanded(
        child: Column(
          children: [
            Text(
              title,
              style: AppStyle.titleExtraSmall(context).copyWith(
                  color: Colors.black.withOpacity(0.5),
                  fontSize: appSize(context: context, unit: 10) / 19),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  text,
                  style: AppStyle.titleLarge(context).copyWith(
                      fontSize: appSize(context: context, unit: 10) / 15),
                ),
              ),
            ),
          ],
        ),
      );

  Widget cancelTicketDialog({
    Function(bool)? showError,
  }) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => CancelTicketBloc(),
        ),
        BlocProvider.value(
          value: context.read<NewTicketBloc>(),
        ),
      ],
      child: StatefulBuilder(builder: (context, dialogState) {
        return Dialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
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
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
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
                          Navigator.of(context, rootNavigator: true).pop();
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: CancelTicketBuilder(
                        onSuccess: () {
                          context.read<NewTicketBloc>().getTickets(status: 1);
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
                ),
                SizedBox(
                  height: sizeHeight(context) / 70,
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
