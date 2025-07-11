import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/features/support_ticket/new_tickets/bloc/new_ticket_bloc.dart';
import 'package:host_visitor_connect/features/support_ticket/new_tickets/ui/new_ticket_builder.dart';

class NewTicketFragment extends StatefulWidget {
  static const routeName = 'voters_listing';
  // final FiltersModel? filters;

  const NewTicketFragment({
    Key? key,
    // this.filters,
  }) : super(key: key);

  @override
  State<NewTicketFragment> createState() => _NewTicketFragmentState();
}

class _NewTicketFragmentState extends State<NewTicketFragment>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    context.read<NewTicketBloc>().getTickets(
          // filters: widget.filters,
          status: 1,
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return const NewTicketListingBuilder(
        // filters: widget.filters,
        );
  }

  @override
  bool get wantKeepAlive => true;
}
