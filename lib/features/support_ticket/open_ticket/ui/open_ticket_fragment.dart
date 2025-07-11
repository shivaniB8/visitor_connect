import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/features/support_ticket/open_ticket/bloc/open_ticket_bloc.dart';
import 'package:host_visitor_connect/features/support_ticket/open_ticket/ui/open_ticket_builder.dart';

class OpenTicketFragment extends StatefulWidget {
  static const routeName = 'voters_listing';
  // final FiltersModel? filters;

  const OpenTicketFragment({
    Key? key,
    // this.filters,
  }) : super(key: key);

  @override
  State<OpenTicketFragment> createState() => _OpenTicketFragmentState();
}

class _OpenTicketFragmentState extends State<OpenTicketFragment>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    context.read<OpenTicketBloc>().getTickets(
          // filters: widget.filters,
          status: 2,
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return const OpenTicketListingBuilder(
        // filters: widget.filters,
        );
  }

  @override
  bool get wantKeepAlive => true;
}
