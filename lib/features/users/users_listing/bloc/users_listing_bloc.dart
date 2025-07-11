import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/common/blocs/state_events/ui_state.dart';
import 'package:host_visitor_connect/common/extensions/future_extensions.dart';
import 'package:host_visitor_connect/common/data/network/responses/page_response.dart';
import 'package:host_visitor_connect/features/users/users_listing/data/network/response/users_data_response.dart';
import 'package:host_visitor_connect/features/users/users_listing/data/repos/user_listing_repository.dart';
import 'package:host_visitor_connect/features/users/users_listing/ui/users/user.dart';
import 'package:host_visitor_connect/features/Filter/data/network/responses/filter_model.dart';

class UsersListingBloc extends Cubit<UiState<List<User>>> {
  PageResponse<UsersDataResponse>? _currentPageResponse;
  final UserListingRepository _userListingRepository;
  List<User> user = [];
  late Completer refreshCompleter;
  FiltersModel? filterModel;

  UsersListingBloc({
    UserListingRepository? userListingRepository,
  })  : _userListingRepository = userListingRepository ?? UserListingRepository(),
        super(Default());

  Future getUsersListing({
    int pageNo = 0,
    bool isRefreshingList = false,
    String searchTerms = '',
    FiltersModel? filters,
  }) {
    filterModel = filters;
    emit(Progress());
    if (pageNo == 0 || isRefreshingList) {
      user.clear();
    }
    if (isRefreshingList) {
      refreshCompleter = Completer();
    }
    return _userListingRepository
        .getUsersListing(
          filtersModel: filterModel,
          pageNo: pageNo,
          searchTerm: filters?.searchTerm,
        )
        .then(_onSuccess)
        .handleError(_onError)
        .whenComplete(() {
      if (isRefreshingList) {
        refreshCompleter.complete();
      }
    });
  }

  void _onSuccess(PageResponse<UsersDataResponse>? pageResponse) {
    pageResponse?.content?.forEach((usersDataResponse) {
      user.add(User.fromApiResponse(usersDataResponse));
    });
    _currentPageResponse = pageResponse;
    emit(Success(user));
  }

  void _onError(exception) {
    emit(Error(exception as Exception));
  }

  void getNextPageOfUsers() {
    if (canLoadMorePages()) {
      getUsersListing(
        filters: filterModel,
        pageNo: (_currentPageResponse?.pageNo ?? 0) + 1,
      );
    }
  }

  bool canLoadMorePages() {
    return state is! Progress && !(_currentPageResponse?.isLast ?? false);
  }

  void refreshUsers({
    bool isRefreshingList = false,
  }) {
    user.clear();
    getUsersListing(
      isRefreshingList: isRefreshingList,
    );
  }
}
