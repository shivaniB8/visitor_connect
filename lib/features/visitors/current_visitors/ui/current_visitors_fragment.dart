import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/features/Filter/data/network/responses/filter_model.dart';
import 'package:host_visitor_connect/features/visitors/current_visitors/bloc/current_visitors_grouping_bloc.dart';
import 'package:host_visitor_connect/features/visitors/current_visitors/ui/current_visitors_listing_builder.dart';

class CurrentVisitorListingFragment extends StatefulWidget {
  final FiltersModel? filtersModel;
  const CurrentVisitorListingFragment({
    Key? key,
    this.filtersModel,
  }) : super(key: key);

  @override
  State<CurrentVisitorListingFragment> createState() =>
      CurrentVisitorListingFragmentState();
}

class CurrentVisitorListingFragmentState
    extends State<CurrentVisitorListingFragment>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    context
        .read<CurrentVisitorsGroupingBloc>()
        .currentVisitorsGrouping(filters: widget.filtersModel);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return CurrentVisitorListingBuilder(
      filtersModel: widget.filtersModel,
    );
  }

  @override
  bool get wantKeepAlive => true;
}
