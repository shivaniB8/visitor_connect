import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/features/visitors/history/bloc/visitors_grouping_bloc.dart';
import 'package:host_visitor_connect/features/Filter/data/network/responses/filter_model.dart';
import 'package:host_visitor_connect/features/visitors/visitor_listing/ui/visitors_listing_builder.dart';

class VisitorListingFragment extends StatefulWidget {
  final FiltersModel? filtersModel;
  const VisitorListingFragment({
    Key? key,
    this.filtersModel,
  }) : super(key: key);

  @override
  State<VisitorListingFragment> createState() => VisitorListingFragmentState();
}

class VisitorListingFragmentState extends State<VisitorListingFragment>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    context
        .read<VisitorsGroupingBloc>()
        .getVisitorsGrouping(filters: widget.filtersModel);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return VisitorListingBuilder(
      filtersModel: widget.filtersModel,
    );
  }

  @override
  bool get wantKeepAlive => true;
}
