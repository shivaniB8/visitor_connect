import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/features/users/users_listing/bloc/users_listing_bloc.dart';
import 'package:host_visitor_connect/features/users/users_listing/ui/users_listing_builder.dart';
import 'package:host_visitor_connect/features/Filter/data/network/responses/filter_model.dart';

class UserListingFragment extends StatefulWidget {
  final FiltersModel? filtersModel;
  const UserListingFragment({
    Key? key,
    this.filtersModel,
  }) : super(key: key);

  @override
  State<UserListingFragment> createState() => UserListingFragmentState();
}

class UserListingFragmentState extends State<UserListingFragment>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    context.read<UsersListingBloc>().getUsersListing();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return UsersListingBuilder(
      filtersModel: widget.filtersModel,
    );
  }

  @override
  bool get wantKeepAlive => true;
}
