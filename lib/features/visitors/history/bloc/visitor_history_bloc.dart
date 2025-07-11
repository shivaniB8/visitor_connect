import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/common/blocs/state_events/ui_state.dart';
import 'package:host_visitor_connect/common/extensions/future_extensions.dart';
import 'package:host_visitor_connect/common/data/network/responses/page_response.dart';
import 'package:host_visitor_connect/common/utils/app_function.dart';
import 'package:host_visitor_connect/features/visitors/history/data/network/responses/visitor_history_response.dart';
import 'package:host_visitor_connect/features/visitors/history/data/repos/visitor_history_repository.dart';
import 'package:host_visitor_connect/features/visitors/history/ui/model/history.dart';

class VisitorsHistoryListingBloc extends Cubit<UiState<List<History>>> {
  PageResponse<VisitorHistoryResponse>? _currentPageResponse;
  final VisitorHistoryRepository _visitorHistoryRepository;
  List<History> visitorHistory = [];
  late Completer refreshCompleter;

  VisitorsHistoryListingBloc({
    VisitorHistoryRepository? visitorHistoryRepository,
  })  : _visitorHistoryRepository = visitorHistoryRepository ?? VisitorHistoryRepository(),
        super(Default());

  Future getVisitorHistoryListing({
    int pageNo = 0,
    required int visitorId,
    bool isRefreshingList = false,
  }) {
    emit(Progress());
    if (pageNo == 0 || isRefreshingList) {
      visitorHistory.clear();
    }
    if (isRefreshingList) {
      refreshCompleter = Completer();
    }
    return _visitorHistoryRepository
        .getVisitorHistoryListing(
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

  void _onSuccess(PageResponse<VisitorHistoryResponse>? pageResponse) {
    if (pageResponse?.sessionExpired == 1) {
      AppFunctions.unAuthorizedEntry(true);
    }
    pageResponse?.content?.forEach((visitorHistoryResponse) {
      visitorHistory.add(History.fromApiResponse(visitorHistoryResponse));
    });

    _currentPageResponse = pageResponse;
    emit(Success(visitorHistory));
  }

  void _onError(exception) {
    emit(Error(exception as Exception));
  }

  void getNextPageOfVisitors(int visitorId) {
    if (canLoadMorePages()) {
      getVisitorHistoryListing(
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
    visitorHistory.clear();
    getVisitorHistoryListing(
      visitorId: visitorId,
      isRefreshingList: isRefreshingList,
    );
  }
}
