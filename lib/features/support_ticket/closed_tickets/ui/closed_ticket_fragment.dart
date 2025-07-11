import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/features/support_ticket/closed_tickets/bloc/closed_ticket_bloc.dart';
import 'package:host_visitor_connect/features/support_ticket/closed_tickets/ui/clsoed_ticket_builder.dart';

class ClosedTicketFragment extends StatefulWidget {
  static const routeName = 'voters_listing';
  // final FiltersModel? filters;

  const ClosedTicketFragment({
    Key? key,
    // this.filters,
  }) : super(key: key);

  @override
  State<ClosedTicketFragment> createState() => _ClosedTicketFragmentState();
}

class _ClosedTicketFragmentState extends State<ClosedTicketFragment>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    context.read<ClosedTicketBloc>().getTickets(
        // filters: widget.filters,
        status: 2);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return const ClosedTicketListingBuilder(
        // filters: widget.filters,
        );
  }

  @override
  bool get wantKeepAlive => true;
}
