import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/common/blank_slate.dart';
import 'package:host_visitor_connect/common/constant/globalVariable.dart';
import 'package:host_visitor_connect/common/custom_widget/loading.dart';
import 'package:host_visitor_connect/common/error_slate.dart';
import 'package:host_visitor_connect/common/utils/common_error_handler.dart';
import 'package:host_visitor_connect/features/visitors/current_visitors/bloc/current_visitors_grouping_bloc.dart';
import 'package:host_visitor_connect/features/Filter/data/network/responses/filter_model.dart';
import 'package:host_visitor_connect/features/visitors/visitor_listing/ui/visitors_group_listing.dart';
import '../../../../common/blocs/state_events/ui_state.dart';

class CurrentVisitorListingBuilder extends StatelessWidget {
  final FiltersModel? filtersModel;
  const CurrentVisitorListingBuilder({
    Key? key,
    this.filtersModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GlobalVariable.callBackCurrentVisitorsList = () async {
      await context.read<CurrentVisitorsGroupingBloc>().currentVisitorsGrouping();
    };
    return RefreshIndicator(
      onRefresh: () async {
        context.read<CurrentVisitorsGroupingBloc>().currentVisitorsGrouping(
              isRefreshingList: true,
            );
        await context.read<CurrentVisitorsGroupingBloc>().refreshCompleter.future;
      },
      child: BlocConsumer(
        bloc: context.read<CurrentVisitorsGroupingBloc>(),
        listener: (context, UiState state) {
          if (state is Error) {
            CommonErrorHandler(
              context,
              exception: state.exception,
            ).showToast();
          }
        },
        builder: (_, UiState state) {
          final rooms = context.read<CurrentVisitorsGroupingBloc>().rooms;

          return state.build(
            defaultState: () => rooms.isEmpty
                ? const BlankSlate(
                    key: Key('blankSlate'),
                    title: 'No Data Available',
                  )
                : VisitorsGroupListing(
                    isFromCurrentVisitors: true,
                    filtersModel: filtersModel,
                    rooms: rooms,
                  ),

            //..
            loading: () => rooms.isEmpty
                ? const Center(child: LoadingWidget())
                : VisitorsGroupListing(
                    isFromCurrentVisitors: true,
                    filtersModel: filtersModel,
                    rooms: rooms,
                  ),

            //..
            success: (_) => rooms.isEmpty
                ? const BlankSlate(
                    key: Key('blankSlate'),
                    title: 'No Data Available',
                  )
                : VisitorsGroupListing(
                    isFromCurrentVisitors: true,
                    filtersModel: filtersModel,
                    rooms: rooms,
                  ),
            //..
            error: (_) => rooms.isEmpty && state is Error
                ? const VoterListingErrorSlate(
                    key: Key('error'),
                  )
                : VisitorsGroupListing(
                    isFromCurrentVisitors: true,
                    filtersModel: filtersModel,
                    rooms: rooms,
                  ),
          );
        },
      ),
    );
  }
}
