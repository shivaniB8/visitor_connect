import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/features/report/report_history/bloc/report_history_bloc.dart';
import 'package:host_visitor_connect/features/report/report_history/ui/report_history_builder.dart';
import 'package:host_visitor_connect/features/report/report_list/ui/model/report.dart';

class ReportHistoryFragment extends StatefulWidget {
  final int? visitorId;
  final Report? report;
  const ReportHistoryFragment({
    Key? key,
    this.visitorId,
    this.report,
  }) : super(key: key);

  @override
  State<ReportHistoryFragment> createState() => ReportHistoryFragmentState();
}

class ReportHistoryFragmentState extends State<ReportHistoryFragment>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    context.read<ReportHistoryListBloc>().getReportHistoryListing(
          visitorId: widget.visitorId ?? 0,
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ReportHistoryBuilder(
        visitorId: widget.visitorId, report: widget.report);
  }

  @override
  bool get wantKeepAlive => true;
}
