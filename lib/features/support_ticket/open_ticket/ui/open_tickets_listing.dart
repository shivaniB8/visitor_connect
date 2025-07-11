import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/common/res/colors.dart';
import 'package:host_visitor_connect/features/support_ticket/model/ticket.dart';
import 'package:host_visitor_connect/features/support_ticket/open_ticket/bloc/open_ticket_bloc.dart';
import 'package:host_visitor_connect/features/support_ticket/open_ticket/ui/list_item_open_ticket.dart';
import 'package:provider/provider.dart';
import '../../../../common/blocs/state_events/ui_state.dart';

class OpenTicketListing extends StatefulWidget {
  final List<Ticket> tickets;
  // final FiltersModel? filters;

  const OpenTicketListing({
    Key? key,
    required this.tickets,
    // this.filters,
  }) : super(key: key);

  @override
  State<OpenTicketListing> createState() => _OpenTicketListingState();
}

class _OpenTicketListingState extends State<OpenTicketListing> {
  late OpenTicketBloc _ticketBloc;
  late ScrollController _ticketListScrollController;

  void _listenToListScroll() {
    final scrollOffset = _ticketListScrollController.offset;
    final scrollPosition = _ticketListScrollController.position;

    //checking scroll offset & position
    if (!scrollPosition.outOfRange) {
      if (scrollOffset >= scrollPosition.maxScrollExtent) {
        //reached bottom
        _ticketBloc.getNextPageOfTickets(
          status: 2,
          // filters: widget.filters,
        );
      }
    }
  }

  @override
  void initState() {
    _ticketBloc = context.read<OpenTicketBloc>();
    _ticketListScrollController = ScrollController();
    _ticketListScrollController.addListener(_listenToListScroll);
    super.initState();
  }

  @override
  void dispose() {
    _ticketListScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.only(top: 10),
        controller: _ticketListScrollController,
        itemCount: widget.tickets.length + 1,
        itemBuilder: (context, index) {
          if (index < widget.tickets.length) {
            return ListItemOpenTicket(
              ticketNo: index + 1,
              ticket: widget.tickets[index],
            );
          } else {
            return _NextPageLoader();
          }
        },
      ),
    );
  }
}

// Loader for when next page of bookings is being fetched
class _NextPageLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ticketBloc = context.read<OpenTicketBloc>();

    return Align(
      child: Container(
        padding: const EdgeInsets.only(top: 24, bottom: 70),
        child: Visibility(
          visible: ticketBloc.state is Progress,
          child: const CircularProgressIndicator(
            color: primary_color,
          ),
        ),
      ),
    );
  }
}
