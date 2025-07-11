import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/common/blank_slate.dart';
import 'package:host_visitor_connect/common/blocs/state_events/ui_state.dart';
import 'package:host_visitor_connect/common/custom_widget/loading.dart';
import 'package:host_visitor_connect/common/error_slate.dart';
import 'package:host_visitor_connect/common/res/colors.dart';
import 'package:host_visitor_connect/common/utils/common_error_handler.dart';
import 'package:host_visitor_connect/features/report/report_history/bloc/report_history_bloc.dart';
import 'package:host_visitor_connect/features/report/report_history/ui/report_history_listing.dart';
import 'package:host_visitor_connect/features/report/report_list/ui/model/report.dart';

class ReportHistoryBuilder extends StatelessWidget {
  final int? visitorId;
  final Report? report;
  const ReportHistoryBuilder({Key? key, this.visitorId, this.report})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<ReportHistoryListBloc>().getReportHistoryListing(
              isRefreshingList: true,
              visitorId: visitorId ?? 0,
            );
        await context.read<ReportHistoryListBloc>().refreshCompleter.future;
      },
      child: BlocConsumer(
        bloc: context.read<ReportHistoryListBloc>(),
        listener: (context, UiState state) {
          if (state is Error) {
            CommonErrorHandler(
              context,
              exception: state.exception,
            ).showToast();
          }
        },
        builder: (_, UiState state) {
          final historyReport =
              context.read<ReportHistoryListBloc>().reportHistory;
          return state.build(
            defaultState: () => historyReport.isEmpty
                ? const BlankSlate(
                    key: Key('blankSlate'),
                    title: 'No Data Available',
                  )
                : ReportHistoryListing(
                    historyReport: historyReport, report: report),

            //..
            loading: () => historyReport.isEmpty
                ? const Center(
                    child: LoadingWidget(
                    color: primary_color,
                  ))
                : ReportHistoryListing(
                    historyReport: historyReport, report: report),

            //..
            success: (_) => historyReport.isEmpty
                ? const BlankSlate(
                    key: Key('blankSlate'),
                    title: 'No Data Available',
                  )
                : ReportHistoryListing(
                    historyReport: historyReport, report: report),
            //..
            error: (_) => historyReport.isEmpty && state is Error
                ? const VoterListingErrorSlate(
                    key: Key('error'),
                  )
                : ReportHistoryListing(
                    historyReport: historyReport, report: report),
          );
        },
      ),
    );
  }
}
