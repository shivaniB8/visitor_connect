import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/common/blank_slate.dart';
import 'package:host_visitor_connect/common/custom_widget/loading.dart';
import 'package:host_visitor_connect/common/error_slate.dart';
import 'package:host_visitor_connect/common/utils/common_error_handler.dart';
import 'package:host_visitor_connect/features/users/users_listing/bloc/users_listing_bloc.dart';
import 'package:host_visitor_connect/features/users/users_listing/ui/users_listing.dart';
import 'package:host_visitor_connect/features/Filter/data/network/responses/filter_model.dart';
import '../../../../common/blocs/state_events/ui_state.dart';

class UsersListingBuilder extends StatelessWidget {
  final FiltersModel? filtersModel;
  const UsersListingBuilder({
    Key? key,
    this.filtersModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<UsersListingBloc>().getUsersListing(
              isRefreshingList: true,
            );
        await context.read<UsersListingBloc>().refreshCompleter.future;
      },
      child: BlocConsumer(
        bloc: context.read<UsersListingBloc>(),
        listener: (context, UiState state) {
          if (state is Error) {
            CommonErrorHandler(
              context,
              exception: state.exception,
            ).showToast();
          }
        },
        builder: (_, UiState state) {
          final users = context.read<UsersListingBloc>().user;
          return state.build(
            defaultState: () => users.isEmpty
                ? const BlankSlate(
                    key: Key('blankSlate'),
                    title: 'No Data Available',
                  )
                : UsersListing(
                    users: users,
                  ),

            //..
            loading: () => users.isEmpty
                ? const Center(child: LoadingWidget())
                : UsersListing(
                    users: users,
                  ),

            //..
            success: (_) => users.isEmpty
                ? const BlankSlate(
                    key: Key('blankSlate'),
                    title: 'No Data Available',
                  )
                : UsersListing(
                    users: users,
                  ),
            //..
            error: (_) => users.isEmpty && state is Error
                ? const VoterListingErrorSlate(
                    key: Key('error'),
                  )
                : UsersListing(
                    users: users,
                  ),
          );
        },
      ),
    );
  }
}
