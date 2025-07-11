import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/common/blocs/state_events/ui_state.dart';
import 'package:host_visitor_connect/common/extensions/future_extensions.dart';
import 'package:host_visitor_connect/common/data/network/responses/page_response.dart';
import 'package:host_visitor_connect/features/report/report_list/data/network/responses/report_list_response.dart';
import 'package:host_visitor_connect/features/report/report_list/data/repos/report_visitor_repository.dart';
import 'package:host_visitor_connect/features/report/report_list/ui/model/report.dart';
import 'package:host_visitor_connect/features/Filter/data/network/responses/filter_model.dart';

class ReportListBloc extends Cubit<UiState<List<Report>>> {
  PageResponse<ReportListResponse>? _currentPageResponse;
  final ReportVisitorRepository _reportVisitorRepository;
  List<Report> reports = [];
  late Completer refreshCompleter;
  bool isSort = false;

  ReportListBloc({
    ReportVisitorRepository? reportVisitorRepository,
  })  : _reportVisitorRepository =
            reportVisitorRepository ?? ReportVisitorRepository(),
        super(Default());

  Future getReportList({
    int pageNo = 0,
    bool isRefreshingList = false,
    String searchTerms = '',
    FiltersModel? filters,
  }) {
    emit(Progress());
    if (pageNo == 0 || isRefreshingList) {
      reports.clear();
    }
    if (isRefreshingList) {
      refreshCompleter = Completer();
    }
    return _reportVisitorRepository
        .getReportList(
            pageNo: pageNo, filterModel: filters, searchTerm: searchTerms)
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
      reports.add(Report.fromApiResponse(reportListResponse));
    });

    _currentPageResponse = pageResponse;
    emit(Success(reports));
  }

  void _onError(exception) {
    emit(Error(exception as Exception));
  }

  void getNextPageOfReports({
    FiltersModel? filtersModel,
  }) {
    if (canLoadMorePages()) {
      getReportList(
        filters: filtersModel,
        pageNo: (_currentPageResponse?.pageNo ?? 0) + 1,
      );
    }
  }

  bool canLoadMorePages() {
    return state is! Progress && !(_currentPageResponse?.isLast ?? false);
  }

  void refreshVisitors({
    bool isRefreshingList = false,
  }) {
    reports.clear();
    getReportList(
      isRefreshingList: isRefreshingList,
    );
  }
}
