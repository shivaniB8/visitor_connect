import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/common/blocs/state_events/ui_state.dart';
import 'package:host_visitor_connect/common/custom_widget/loading.dart';
import 'package:host_visitor_connect/common/res/colors.dart';
import 'package:host_visitor_connect/features/report/report_history/bloc/report_history_bloc.dart';

import 'package:host_visitor_connect/features/report/report_list/ui/list_item_report.dart';
import 'package:host_visitor_connect/features/report/report_list/ui/model/report.dart';

class ReportHistoryListing extends StatefulWidget {
  final int? visitorId;
  final List<Report> historyReport;
  final Report? report;
  const ReportHistoryListing({
    Key? key,
    required this.historyReport,
    this.report,
    this.visitorId,
  }) : super(key: key);

  @override
  State<ReportHistoryListing> createState() => _ReportHistoryListingState();
}

class _ReportHistoryListingState extends State<ReportHistoryListing> {
  late ReportHistoryListBloc _reportHistoryListBloc;
  late ScrollController _reportHistoryListScrollController;

  void _listenToListScroll() {
    final scrollOffset = _reportHistoryListScrollController.offset;
    final scrollPosition = _reportHistoryListScrollController.position;

    // checking scroll offset & position
    if (!scrollPosition.outOfRange) {
      if (scrollOffset >= scrollPosition.maxScrollExtent) {
        //reached bottom
        _reportHistoryListBloc.getNextPageOfReports(
          widget.visitorId ?? 0,
        );
      }
    }
  }

  @override
  void initState() {
    _reportHistoryListBloc = context.read<ReportHistoryListBloc>();
    _reportHistoryListScrollController = ScrollController();
    _reportHistoryListScrollController.addListener(_listenToListScroll);

    super.initState();
  }

  @override
  void dispose() {
    _reportHistoryListScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        color: Colors.white,
        child: ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.only(top: 10),
          controller: _reportHistoryListScrollController,
          itemCount: widget.historyReport.length + 1,
          itemBuilder: (context, index) {
            if (index < widget.historyReport.length) {
              return ListItemReport(
                fullName: widget.historyReport[index].visitorFkValue,
                reportBy: widget.historyReport[index].reportedUserName,
                reportOn: widget.historyReport[index].timeReported,
                reportDetails: widget.historyReport[index].reportDetails,
                reportReason: widget.historyReport[index].reasonValue,
                aadharPhoto: widget.report?.aadharPhoto,
                visitorPhoto: widget.report?.visitorPhoto,
                age: widget.historyReport[index].age,
                gender: widget.historyReport[index].gender,
                visitorFk: widget.historyReport[index].visitorFk,
                roomNo: widget.historyReport[index].roomNo,
                isReportHistory: true,
              );
            } else {
              return _NextPageLoader();
            }
          },
        ),
      ),
    );
  }
}

// Loader for when next page of bookings is being fetched
class _NextPageLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final voterListingBloc = context.read<ReportHistoryListBloc>();

    return Align(
      child: Container(
        padding: const EdgeInsets.only(top: 24, bottom: 70),
        child: Visibility(
          visible: voterListingBloc.state is Progress,
          child: const LoadingWidget(
            color: primary_color,
          ),
        ),
      ),
    );
  }
}
