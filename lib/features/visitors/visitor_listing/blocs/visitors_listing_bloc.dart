import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/common/blocs/state_events/ui_state.dart';
import 'package:host_visitor_connect/common/extensions/future_extensions.dart';
import 'package:host_visitor_connect/common/data/network/responses/page_response.dart';
import 'package:host_visitor_connect/common/utils/app_function.dart';
import 'package:host_visitor_connect/features/visitors/visitor_listing/data/network/responses/visitor_details_response.dart';
import 'package:host_visitor_connect/features/visitors/visitor_listing/data/repos/visitor_repository.dart';
import 'package:host_visitor_connect/features/Filter/data/network/responses/filter_model.dart';
import 'package:host_visitor_connect/features/visitors/visitor_listing/ui/model/visitor.dart';

class VisitorsListingBloc extends Cubit<UiState<List<Visitor>>> {
  PageResponse<VisitorDetailsResponse>? _currentPageResponse;
  final VisitorRepository _visitorRepository;
  List<Visitor> visitor = [];
  late Completer refreshCompleter;

  VisitorsListingBloc({
    VisitorRepository? visitorRepository,
  })  : _visitorRepository = visitorRepository ?? VisitorRepository(),
        super(Default());

  Future getVisitorListing({
    int pageNo = 0,
    bool isRefreshingList = false,
    FiltersModel? filters,
  }) {
    emit(Progress());
    if (pageNo == 0 || isRefreshingList) {
      visitor.clear();
    }
    if (isRefreshingList) {
      refreshCompleter = Completer();
    }
    return _visitorRepository
        .getVisitorListing(pageNo: pageNo, filterModel: filters, searchTerm: filters?.searchTerm)
        .then(_onSuccess)
        .handleError(_onError)
        .whenComplete(() {
      if (isRefreshingList) {
        refreshCompleter.complete();
      }
    });
  }

  void _onSuccess(PageResponse<VisitorDetailsResponse>? pageResponse) {
    if (pageResponse?.sessionExpired == 1) {
      AppFunctions.unAuthorizedEntry(true);
    }
    pageResponse?.content?.forEach((visitorDetailsResponse) {
      visitor.add(Visitor.fromApiResponse(visitorDetailsResponse));
    });
    _currentPageResponse = pageResponse;
    emit(Success(visitor));
  }

  void _onError(exception) {
    emit(Error(exception as Exception));
  }

  void getNextPageOfVisitors() {
    if (canLoadMorePages()) {
      getVisitorListing(
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
    visitor.clear();
    getVisitorListing(
      isRefreshingList: isRefreshingList,
    );
  }
}
