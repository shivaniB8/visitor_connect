import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/features/Filter/data/network/responses/filter_model.dart';
import 'package:host_visitor_connect/features/rent/rented_listing/bloc/rented_listing_bloc.dart';
import 'package:host_visitor_connect/features/rent/rented_listing/ui/rented_listing_builder.dart';

class RentedListingFragment extends StatefulWidget {
  final FiltersModel? filtersModel;
  const RentedListingFragment({
    Key? key,
    this.filtersModel,
  }) : super(key: key);

  @override
  State<RentedListingFragment> createState() => RentedListingFragmentState();
}

class RentedListingFragmentState extends State<RentedListingFragment>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    context.read<RentedListingBloc>().rentedListing(filters: widget.filtersModel);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RentedListingBuilder(
      filtersModel: widget.filtersModel,
    );
  }

  @override
  bool get wantKeepAlive => true;
}
