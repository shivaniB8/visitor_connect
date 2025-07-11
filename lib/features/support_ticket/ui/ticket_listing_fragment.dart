import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/features/support_ticket/bloc/ticket_history_bloc.dart';
import 'package:host_visitor_connect/features/support_ticket/ui/ticket_history_builder.dart';

class TicketListingFragment extends StatefulWidget {
  final int? sa1;
  final ScrollController scrollController;

  // final FiltersModel? filtersModel;
  const TicketListingFragment({
    Key? key,
    this.sa1,
    required this.scrollController,
    // this.filtersModel,
  }) : super(key: key);

  @override
  State<TicketListingFragment> createState() => TicketListingFragmentState();
}

class TicketListingFragmentState extends State<TicketListingFragment>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    context.read<TicketHistoryBloc>().getTicketHistory(sa1: widget.sa1 ?? 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return TicketHistoryBuilder(
      scrollController: widget.scrollController,
      // filtersModel: widget.filtersModel,
    );
  }

  @override
  bool get wantKeepAlive => true;
}
