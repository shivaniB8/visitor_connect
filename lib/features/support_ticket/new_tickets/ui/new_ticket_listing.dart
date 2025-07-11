import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/common/custom_widget/loading.dart';
import 'package:host_visitor_connect/features/support_ticket/model/ticket.dart';
import 'package:host_visitor_connect/features/support_ticket/new_tickets/bloc/new_ticket_bloc.dart';
import 'package:host_visitor_connect/features/support_ticket/new_tickets/ui/list_item_new_ticket.dart';
import 'package:provider/provider.dart';

import '../../../../common/blocs/state_events/ui_state.dart';

class NewTicketListing extends StatefulWidget {
  final List<Ticket> tickets;
  // final FiltersModel? filters;

  const NewTicketListing({
    Key? key,
    required this.tickets,
    // this.filters,
  }) : super(key: key);

  @override
  State<NewTicketListing> createState() => _NewTicketListingState();
}

class _NewTicketListingState extends State<NewTicketListing> {
  late NewTicketBloc _ticketBloc;
  late ScrollController _votersListScrollController;

  void _listenToListScroll() {
    final scrollOffset = _votersListScrollController.offset;
    final scrollPosition = _votersListScrollController.position;

    //checking scroll offset & position
    if (!scrollPosition.outOfRange) {
      if (scrollOffset >= scrollPosition.maxScrollExtent) {
        //reached bottom
        _ticketBloc.getNextPageOfTickets(
          status: 1,

          // filters: widget.filters,
        );
      }
    }
  }

  @override
  void initState() {
    _ticketBloc = context.read<NewTicketBloc>();
    _votersListScrollController = ScrollController();
    _votersListScrollController.addListener(_listenToListScroll);
    super.initState();
  }

  @override
  void dispose() {
    _votersListScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.only(top: 10),
      controller: _votersListScrollController,
      itemCount: widget.tickets.length + 1,
      itemBuilder: (context, index) {
        if (index < widget.tickets.length) {
          return GestureDetector(
            child: ListItemNewTicket(
              ticketNo: index + 1,
              ticket: widget.tickets[index],
            ),
            onTap: () {},
          );
        } else {
          return _NextPageLoader();
        }
      },
    );
  }
}

// Loader for when next page of bookings is being fetched
class _NextPageLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ticketBloc = context.read<NewTicketBloc>();

    return Align(
      child: Container(
        padding: const EdgeInsets.only(top: 24, bottom: 70),
        child: Visibility(
          visible: ticketBloc.state is Progress,
          child: const LoadingWidget(),
        ),
      ),
    );
  }
}
