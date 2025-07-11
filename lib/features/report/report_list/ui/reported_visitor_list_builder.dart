import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/common/blank_slate.dart';
import 'package:host_visitor_connect/common/custom_widget/loading.dart';
import 'package:host_visitor_connect/common/error_slate.dart';
import 'package:host_visitor_connect/common/res/colors.dart';
import 'package:host_visitor_connect/common/utils/common_error_handler.dart';

import 'package:host_visitor_connect/features/report/report_list/bloc/report_list_bloc.dart';
import 'package:host_visitor_connect/features/report/report_list/ui/report_listing.dart';

import '../../../../common/blocs/state_events/ui_state.dart';

class ReportedVisitorListBuilder extends StatelessWidget {
  const ReportedVisitorListBuilder({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<ReportListBloc>().isSort = false;
        context.read<ReportListBloc>().getReportList(
              isRefreshingList: true,
            );
        await context.read<ReportListBloc>().refreshCompleter.future;
      },
      child: BlocConsumer(
        bloc: context.read<ReportListBloc>(),
        listener: (context, UiState state) {
          if (state is Error) {
            CommonErrorHandler(
              context,
              exception: state.exception,
            ).showToast();
          }
        },
        builder: (_, UiState state) {
          final reports = context.read<ReportListBloc>().reports;
          return state.build(
            defaultState: () => reports.isEmpty
                ? const BlankSlate(
                    key: Key('blankSlate'),
                    title: 'No Data Available',
                  )
                : ReportListing(
                    reports: reports,
                  ),

            //..
            loading: () => reports.isEmpty
                ? const Center(
                    child: LoadingWidget(
                    color: primary_color,
                  ))
                : ReportListing(
                    reports: reports,
                  ),

            //..
            success: (_) => reports.isEmpty
                ? const BlankSlate(
                    key: Key('blankSlate'),
                    title: 'No Data Available',
                  )
                : ReportListing(
                    reports: reports,
                  ),
            //..
            error: (_) => reports.isEmpty && state is Error
                ? const VoterListingErrorSlate(
                    key: Key('error'),
                  )
                : ReportListing(
                    reports: reports,
                  ),
          );
        },
      ),
    );
  }
}
