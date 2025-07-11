import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/common/blocs/state_events/ui_state.dart';
import 'package:host_visitor_connect/common/extensions/future_extensions.dart';
import 'package:host_visitor_connect/common/data/network/responses/page_response.dart';
import 'package:host_visitor_connect/features/report/report_history/data/repos/report_history_repository.dart';
import 'package:host_visitor_connect/features/report/report_list/data/network/responses/report_list_response.dart';
import 'package:host_visitor_connect/features/report/report_list/ui/model/report.dart';

class ReportHistoryListBloc extends Cubit<UiState<List<Report>>> {
  PageResponse<ReportListResponse>? _currentPageResponse;
  final ReportHistoryRepository _reportHistoryRepository;
  List<Report> reportHistory = [];
  late Completer refreshCompleter;

  ReportHistoryListBloc({
    ReportHistoryRepository? reportHistoryRepository,
  })  : _reportHistoryRepository =
            reportHistoryRepository ?? ReportHistoryRepository(),
        super(Default());

  Future getReportHistoryListing({
    int pageNo = 0,
    required int visitorId,
    bool isRefreshingList = false,
  }) {
    emit(Progress());
    if (pageNo == 0 || isRefreshingList) {
      reportHistory.clear();
    }
    if (isRefreshingList) {
      refreshCompleter = Completer();
    }
    return _reportHistoryRepository
        .getReportList(
          visitorId: visitorId,
          pageNo: pageNo,
        )
        .then(_onSuccess)
        .handleError(_onError)
        .whenComplete(() {
      if (isRefreshingList) {
        refreshCompleter.complete();
      }
    });
  }

  void _onSuccess(PageResponse<ReportListResponse>? pageResponse) {
    pageResponse?.content?.forEach((reportListResponse) {
      reportHistory.add(Report.fromApiResponse(reportListResponse));
    });

    _currentPageResponse = pageResponse;
    emit(Success(reportHistory));
  }

  void _onError(exception) {
    emit(Error(exception as Exception));
  }

  void getNextPageOfReports(int visitorId) {
    if (canLoadMorePages()) {
      getReportHistoryListing(
        visitorId: visitorId,
        pageNo: (_currentPageResponse?.pageNo ?? 0) + 1,
      );
    }
  }

  bool canLoadMorePages() {
    return state is! Progress && !(_currentPageResponse?.isLast ?? false);
  }

  void refreshVisitors({
    bool isRefreshingList = false,
    required int visitorId,
  }) {
    reportHistory.clear();
    getReportHistoryListing(
      visitorId: visitorId,
      isRefreshingList: isRefreshingList,
    );
  }
}
