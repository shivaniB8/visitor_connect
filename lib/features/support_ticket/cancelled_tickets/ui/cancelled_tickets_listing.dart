import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/common/custom_widget/loading.dart';
import 'package:host_visitor_connect/features/support_ticket/cancelled_tickets/bloc/cancelled_ticket_bloc.dart';
import 'package:host_visitor_connect/features/support_ticket/cancelled_tickets/ui/list_item_cancelled_ticket.dart';
import 'package:host_visitor_connect/features/support_ticket/model/ticket.dart';
import 'package:provider/provider.dart';

import '../../../../common/blocs/state_events/ui_state.dart';

class CancelledTicketListing extends StatefulWidget {
  final List<Ticket> tickets;
  // final FiltersModel? filters;

  const CancelledTicketListing({
    Key? key,
    required this.tickets,
    // this.filters,
  }) : super(key: key);

  @override
  State<CancelledTicketListing> createState() => _CancelledTicketListingState();
}

class _CancelledTicketListingState extends State<CancelledTicketListing> {
  late CancelledTicketBloc _ticketBloc;
  late ScrollController _ticketListScrollController;

  void _listenToListScroll() {
    final scrollOffset = _ticketListScrollController.offset;
    final scrollPosition = _ticketListScrollController.position;

    //checking scroll offset & position
    if (!scrollPosition.outOfRange) {
      if (scrollOffset >= scrollPosition.maxScrollExtent) {
        //reached bottom
        _ticketBloc.getNextPageOfTickets(
          status: 5,
          // filters: widget.filters,
        );
      }
    }
  }

  // void _listenToTeamScroll() {
  //   final teamScrollOffset = _voterTeamListScrollController.offset;
  //   final teamScrollPosition = _voterTeamListScrollController.position;
  //
  //   //reached bottom
  //   if (!teamScrollPosition.outOfRange && (widget.isTeam ?? false)) {
  //     if (teamScrollOffset >= teamScrollPosition.maxScrollExtent) {
  //       //reached bottom
  //       _voterTeamListingBloc.getNextPageOfBookings();
  //     }
  //   }
  // }

  @override
  void initState() {
    _ticketBloc = context.read<CancelledTicketBloc>();
    _ticketListScrollController = ScrollController();
    _ticketListScrollController.addListener(_listenToListScroll);

    // if (widget.isTeam ?? false) {
    //   _voterTeamListingBloc = context.read<VoterTeamListingBoc>();
    //   _voterTeamListScrollController = ScrollController();
    //   _voterTeamListScrollController.addListener(_listenToTeamScroll);
    // }

    super.initState();
  }

  @override
  void dispose() {
    _ticketListScrollController.dispose();
    // if (widget.isTeam ?? false) {
    //   _voterTeamListScrollController.dispose();
    // }
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
            return ListItemCancelledTicket(
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
    final ticketBloc = context.read<CancelledTicketBloc>();

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
