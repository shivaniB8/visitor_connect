import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/common/blocs/state_events/ui_state.dart';
import 'package:host_visitor_connect/common/custom_widget/loading.dart';

import 'package:host_visitor_connect/features/visitors/history/bloc/visitor_history_bloc.dart';
import 'package:host_visitor_connect/features/visitors/history/ui/list_item_history.dart';
import 'package:host_visitor_connect/features/visitors/history/ui/model/history.dart';
import 'package:host_visitor_connect/features/visitors/visitor_listing/ui/model/visitor.dart';

class VisitorHistoryListing extends StatefulWidget {
  final int? visitorId;
  final List<History> history;
  final Visitor? visitor;
  const VisitorHistoryListing({
    Key? key,
    required this.history,
    this.visitorId,
    this.visitor,
  }) : super(key: key);

  @override
  State<VisitorHistoryListing> createState() => _VisitorHistoryListingState();
}

class _VisitorHistoryListingState extends State<VisitorHistoryListing> {
  late VisitorsHistoryListingBloc _visitorsHistoryListingBloc;
  late ScrollController _visitorHistoryListScrollController;

  void _listenToListScroll() {
    final scrollOffset = _visitorHistoryListScrollController.offset;
    final scrollPosition = _visitorHistoryListScrollController.position;

    // checking scroll offset & position
    if (!scrollPosition.outOfRange) {
      if (scrollOffset >= scrollPosition.maxScrollExtent) {
        //reached bottom
        _visitorsHistoryListingBloc.getNextPageOfVisitors(
          widget.visitorId ?? 0,
        );
      }
    }
  }

  @override
  void initState() {
    _visitorsHistoryListingBloc = context.read<VisitorsHistoryListingBloc>();
    _visitorHistoryListScrollController = ScrollController();
    _visitorHistoryListScrollController.addListener(_listenToListScroll);

    super.initState();
  }

  @override
  void dispose() {
    _visitorHistoryListScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        color: Colors.white,
        child: ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.only(top: 10),
          controller: _visitorHistoryListScrollController,
          itemCount: widget.history.length + 1,
          itemBuilder: (context, index) {
            if (index < widget.history.length) {
              return ListItemHistory(
                history: widget.history[index],
                visitor: widget.visitor,
              );
            } else {
              return _NextPageLoader();
            }
          },
        ),
      ),
    );
  }
}

// Loader for when next page of bookings is being fetched
class _NextPageLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final voterListingBloc = context.read<VisitorsHistoryListingBloc>();

    return Align(
      child: Container(
        padding: const EdgeInsets.only(top: 24, bottom: 70),
        child: Visibility(
          visible: voterListingBloc.state is Progress,
          child: const LoadingWidget(),
        ),
      ),
    );
  }
}
