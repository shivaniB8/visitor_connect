import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/common/blocs/state_events/ui_state.dart';
import 'package:host_visitor_connect/common/extensions/future_extensions.dart';
import 'package:host_visitor_connect/common/data/network/responses/page_response.dart';
import 'package:host_visitor_connect/common/utils/app_function.dart';
import 'package:host_visitor_connect/features/Filter/data/network/responses/filter_model.dart';
import 'package:host_visitor_connect/features/rent/rented_listing/data/repos/rent_repository.dart';
import 'package:host_visitor_connect/features/visitors/history/data/network/responses/visitor_room_response.dart';
import 'package:host_visitor_connect/features/visitors/visitor_listing/ui/model/visitor.dart';

class RentedListingBloc extends Cubit<UiState<List<Room>>> {
  PageResponse<VisitorRoomResponse>? _currentPageResponse;
  final RentedListingRepository _rentedListingRepository;
  List<Room> rooms = [];
  int? orderByValue;
  late Completer refreshCompleter;

  RentedListingBloc({
    RentedListingRepository? rentedListingRepository,
  })  : _rentedListingRepository = rentedListingRepository ?? RentedListingRepository(),
        super(Default());

  Future rentedListing({
    int pageNo = 0,
    bool isRefreshingList = false,
    String searchTerms = '',
    FiltersModel? filters,
    int? orderBy,
  }) {
    orderByValue = orderBy;
    emit(Progress());
    if (pageNo == 0 || isRefreshingList) {
      rooms.clear();
    }
    if (isRefreshingList) {
      refreshCompleter = Completer();
    }
    return _rentedListingRepository
        .rentedListing(
          pageNo: pageNo,
          filterModel: filters,
          searchTerm: searchTerms,
          orderBy: orderByValue,
        )
        .then(_onSuccess)
        .handleError(_onError)
        .whenComplete(() {
      if (isRefreshingList) {
        refreshCompleter.complete();
      }
    });
  }

  void _onSuccess(PageResponse<VisitorRoomResponse>? pageResponse) {
    if (pageResponse?.sessionExpired == 1) {
      AppFunctions.unAuthorizedEntry(true);
    }
    pageResponse?.content?.forEach((visitorsRoomResponse) {
      rooms.add(Room.fromApiResponse(visitorsRoomResponse));
    });
    _currentPageResponse = pageResponse;
    emit(Success(rooms));
  }

  void _onError(exception) {
    emit(Error(exception as Exception));
  }

  void getNextPageOfRooms({
    FiltersModel? filtersModel,
  }) {
    if (canLoadMorePages()) {
      rentedListing(
        orderBy: orderByValue,
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
    rooms.clear();
    rentedListing(
      isRefreshingList: isRefreshingList,
    );
  }
}
