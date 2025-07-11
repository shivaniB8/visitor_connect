import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/features/visitors/history/bloc/visitor_history_bloc.dart';
import 'package:host_visitor_connect/features/visitors/history/ui/visitor_history_builder.dart';
import 'package:host_visitor_connect/features/visitors/visitor_listing/ui/model/visitor.dart';

class VisitorsHistoryFragment extends StatefulWidget {
  final int? visitorId;
  final Visitor? visitor;
  const VisitorsHistoryFragment({
    Key? key,
    this.visitorId,
    this.visitor,
  }) : super(key: key);

  @override
  State<VisitorsHistoryFragment> createState() => VisitorsHistoryFragmentState();
}

class VisitorsHistoryFragmentState extends State<VisitorsHistoryFragment>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    context.read<VisitorsHistoryListingBloc>().getVisitorHistoryListing(
          visitorId: widget.visitorId ?? 0,
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return VisitorHistoryBuilder(
      visitorId: widget.visitorId,
      visitor: widget.visitor,
    );
  }

  @override
  bool get wantKeepAlive => true;
}
