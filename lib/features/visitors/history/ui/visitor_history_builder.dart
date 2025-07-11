import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/common/blank_slate.dart';
import 'package:host_visitor_connect/common/custom_widget/loading.dart';
import 'package:host_visitor_connect/common/error_slate.dart';
import 'package:host_visitor_connect/common/utils/common_error_handler.dart';
import 'package:host_visitor_connect/features/visitors/history/bloc/visitor_history_bloc.dart';
import 'package:host_visitor_connect/features/visitors/history/ui/visitor_history_listing.dart';
import 'package:host_visitor_connect/features/visitors/visitor_listing/ui/model/visitor.dart';
import '../../../../common/blocs/state_events/ui_state.dart';

class VisitorHistoryBuilder extends StatelessWidget {
  final int? visitorId;
  final Visitor? visitor;
  const VisitorHistoryBuilder({
    Key? key,
    this.visitorId,
    this.visitor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<VisitorsHistoryListingBloc>().getVisitorHistoryListing(
              isRefreshingList: true,
              visitorId: visitorId ?? 0,
            );
        await context.read<VisitorsHistoryListingBloc>().refreshCompleter.future;
      },
      child: BlocConsumer(
        bloc: context.read<VisitorsHistoryListingBloc>(),
        listener: (context, UiState state) {
          if (state is Error) {
            CommonErrorHandler(
              context,
              exception: state.exception,
            ).showToast();
          }
        },
        builder: (_, UiState state) {
          final historyList = context.read<VisitorsHistoryListingBloc>().visitorHistory;
          return state.build(
            defaultState: () => historyList.isEmpty
                ? const BlankSlate(
                    key: Key('blankSlate'),
                    title: 'No Data Available',
                  )
                : VisitorHistoryListing(
                    history: historyList,
                    visitor: visitor,
                  ),

            //..
            loading: () => historyList.isEmpty
                ? const Center(child: LoadingWidget())
                : VisitorHistoryListing(
                    history: historyList,
                    visitor: visitor,
                  ),

            //..
            success: (_) => historyList.isEmpty
                ? const BlankSlate(
                    key: Key('blankSlate'),
                    title: 'No Data Available',
                  )
                : VisitorHistoryListing(
                    history: historyList,
                    visitor: visitor,
                  ),
            //..
            error: (_) => historyList.isEmpty && state is Error
                ? const VoterListingErrorSlate(
                    key: Key('error'),
                  )
                : VisitorHistoryListing(
                    history: historyList,
                    visitor: visitor,
                  ),
          );
        },
      ),
    );
  }
}
