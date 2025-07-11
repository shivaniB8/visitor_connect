import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/features/support_ticket/cancelled_tickets/bloc/cancelled_ticket_bloc.dart';
import 'package:host_visitor_connect/features/support_ticket/cancelled_tickets/ui/cancelled_ticket_builder.dart';

class CancelledTicketFragment extends StatefulWidget {
  static const routeName = 'voters_listing';
  // final FiltersModel? filters;

  const CancelledTicketFragment({
    Key? key,
    // this.filters,
  }) : super(key: key);

  @override
  State<CancelledTicketFragment> createState() =>
      _CancelledTicketFragmentState();
}

class _CancelledTicketFragmentState extends State<CancelledTicketFragment>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    context.read<CancelledTicketBloc>().getTickets(
        // filters: widget.filters,
        status: 2);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return const CancelledTicketListingBuilder(
        // filters: widget.filters,
        );
  }

  @override
  bool get wantKeepAlive => true;
}
