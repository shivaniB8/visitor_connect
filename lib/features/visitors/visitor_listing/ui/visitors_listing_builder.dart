import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/common/blank_slate.dart';
import 'package:host_visitor_connect/common/constant/globalVariable.dart';
import 'package:host_visitor_connect/common/custom_widget/loading.dart';
import 'package:host_visitor_connect/common/error_slate.dart';
import 'package:host_visitor_connect/common/utils/common_error_handler.dart';
import 'package:host_visitor_connect/features/visitors/history/bloc/visitors_grouping_bloc.dart';
import 'package:host_visitor_connect/features/Filter/data/network/responses/filter_model.dart';
import 'package:host_visitor_connect/features/visitors/visitor_listing/ui/visitors_group_listing.dart';
import '../../../../common/blocs/state_events/ui_state.dart';

class VisitorListingBuilder extends StatelessWidget {
  final FiltersModel? filtersModel;
  const VisitorListingBuilder({
    Key? key,
    this.filtersModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GlobalVariable.callBackVisitorsList = () async {
      await context.read<VisitorsGroupingBloc>().getVisitorsGrouping();
    };
    return RefreshIndicator(
      onRefresh: () async {
        context.read<VisitorsGroupingBloc>().getVisitorsGrouping(
              isRefreshingList: true,
            );
        await context.read<VisitorsGroupingBloc>().refreshCompleter.future;
      },
      child: BlocConsumer(
        bloc: context.read<VisitorsGroupingBloc>(),
        listener: (context, UiState state) {
          if (state is Error) {
            CommonErrorHandler(
              context,
              exception: state.exception,
            ).showToast();
          }
        },
        builder: (_, UiState state) {
          final rooms = context.read<VisitorsGroupingBloc>().rooms;

          return state.build(
            defaultState: () => rooms.isEmpty
                ? const BlankSlate(
                    key: Key('blankSlate'),
                    title: 'No Data Available',
                  )
                : VisitorsGroupListing(
                    isFromCurrentVisitors: false,
                    filtersModel: filtersModel,
                    rooms: rooms,
                  ),

            //..
            loading: () => rooms.isEmpty
                ? const Center(child: LoadingWidget())
                : VisitorsGroupListing(
                    isFromCurrentVisitors: false,
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
                    isFromCurrentVisitors: false,
                    filtersModel: filtersModel,
                    rooms: rooms,
                  ),
            //..
            error: (_) => rooms.isEmpty && state is Error
                ? const VoterListingErrorSlate(
                    key: Key('error'),
                  )
                : VisitorsGroupListing(
                    isFromCurrentVisitors: false,
                    filtersModel: filtersModel,
                    rooms: rooms,
                  ),
          );
        },
      ),
    );
  }
}
