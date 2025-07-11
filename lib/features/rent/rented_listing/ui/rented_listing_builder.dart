import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/common/blank_slate.dart';
import 'package:host_visitor_connect/common/constant/globalVariable.dart';
import 'package:host_visitor_connect/common/custom_widget/loading.dart';
import 'package:host_visitor_connect/common/error_slate.dart';
import 'package:host_visitor_connect/common/utils/common_error_handler.dart';
import 'package:host_visitor_connect/features/rent/rented_listing/bloc/rented_listing_bloc.dart';
import 'package:host_visitor_connect/features/rent/rented_listing/ui/rented_listing.dart';
import 'package:host_visitor_connect/features/Filter/data/network/responses/filter_model.dart';
import '../../../../common/blocs/state_events/ui_state.dart';

class RentedListingBuilder extends StatelessWidget {
  final FiltersModel? filtersModel;
  const RentedListingBuilder({
    Key? key,
    this.filtersModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GlobalVariable.callBackRentedList = () async {
      await context.read<RentedListingBloc>().rentedListing();
    };
    return RefreshIndicator(
      onRefresh: () async {
        context.read<RentedListingBloc>().rentedListing(
              isRefreshingList: true,
            );
        await context.read<RentedListingBloc>().refreshCompleter.future;
      },
      child: BlocConsumer(
        bloc: context.read<RentedListingBloc>(),
        listener: (context, UiState state) {
          if (state is Error) {
            CommonErrorHandler(
              context,
              exception: state.exception,
            ).showToast();
          }
        },
        builder: (_, UiState state) {
          final rooms = context.read<RentedListingBloc>().rooms;
          return state.build(
            defaultState: () => rooms.isEmpty
                ? const BlankSlate(
                    key: Key('blankSlate'),
                    title: 'No Data Available',
                  )
                : RentedListing(
                    rooms: rooms,
                  ),

            //..
            loading: () => rooms.isEmpty
                ? const Center(child: LoadingWidget())
                : RentedListing(
                    rooms: rooms,
                  ),

            //..
            success: (_) => rooms.isEmpty
                ? const BlankSlate(
                    key: Key('blankSlate'),
                    title: 'No Data Available',
                  )
                : RentedListing(
                    rooms: rooms,
                  ),
            //..
            error: (_) => rooms.isEmpty && state is Error
                ? const VoterListingErrorSlate(
                    key: Key('error'),
                  )
                : RentedListing(
                    rooms: rooms,
                  ),
          );
        },
      ),
    );
  }
}
