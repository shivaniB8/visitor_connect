import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/common/blocs/state_events/ui_state.dart';
import 'package:host_visitor_connect/common/extensions/future_extensions.dart';
import 'package:host_visitor_connect/common/data/network/responses/page_response.dart';
import 'package:host_visitor_connect/features/visitors/visitor_listing/data/network/responses/visitor_details_response.dart';
import 'package:host_visitor_connect/features/visitors/visitor_listing/data/repos/visitor_repository.dart';
import 'package:host_visitor_connect/features/visitors/visitor_listing/ui/model/visitor.dart';

class ReportVisitorSearchTermBloc extends Cubit<UiState<List<Visitor>>> {
  PageResponse<VisitorDetailsResponse>? _currentPageResponse;
  final VisitorRepository _visitorRepository;
  List<Visitor> visitor = [];
  late Completer refreshCompleter;

  ReportVisitorSearchTermBloc({
    VisitorRepository? visitorRepository,
  })  : _visitorRepository = visitorRepository ?? VisitorRepository(),
        super(Default());

  void visitorSearchReport({
    int pageNo = 0,
    required String searchTerm,
    bool isRefreshingList = false,
  }) {
    emit(Progress());
    if (pageNo == 0 || isRefreshingList) {
      visitor.clear();
    }
    if (isRefreshingList) {
      refreshCompleter = Completer();
    }
    _visitorRepository
        .getVisitorListing(
          pageNo: pageNo,
          searchTerm: searchTerm,
        )
        .then(_onSuccess)
        .handleError(_onError)
        .whenComplete(() {
      if (isRefreshingList) {
        refreshCompleter.complete();
      }
    });
  }

  void _onSuccess(PageResponse<VisitorDetailsResponse>? pageResponse) {
    pageResponse?.content?.forEach((visitorDetailsResponse) {
      visitor.add(Visitor.fromApiResponse(visitorDetailsResponse));
    });
    _currentPageResponse = pageResponse;
    emit(Success(visitor));
  }

  void _onError(exception) {
    emit(Error(exception as Exception));
  }

  void getNextPageOfVoters({
    required String searchTerm,
  }) {
    if (canLoadMorePages()) {
      visitorSearchReport(
        searchTerm: searchTerm,
        pageNo: (_currentPageResponse?.pageNo ?? 0) + 1,
      );
    }
  }

  bool canLoadMorePages() {
    return state is! Progress && !(_currentPageResponse?.isLast ?? false);
  }

  void refreshVoters({
    bool isRefreshingList = false,
    String? searchTerm,
  }) {
    visitor.clear();
    visitorSearchReport(
      searchTerm: searchTerm ?? '',
      isRefreshingList: isRefreshingList,
    );
  }
}
