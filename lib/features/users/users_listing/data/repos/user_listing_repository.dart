import 'package:host_visitor_connect/common/data/network/responses/page_response.dart';
import 'package:host_visitor_connect/features/users/add_user/data/network/api_services/users_listing_api_service.dart';
import 'package:host_visitor_connect/features/users/users_listing/data/network/response/users_data_response.dart';
import 'package:host_visitor_connect/features/Filter/data/network/responses/filter_model.dart';

class UserListingRepository {
  final UsersListingApiService _usersListingApiService;

  UserListingRepository({UsersListingApiService? usersListingApiService})
      : _usersListingApiService =
            usersListingApiService ?? UsersListingApiService();

  Future<PageResponse<UsersDataResponse>> getUsersListing({
    required int pageNo,
    String? searchTerm,
    FiltersModel? filtersModel,
  }) {
    return _usersListingApiService.usersListing(
      pageNo: pageNo,
      searchTerm: searchTerm,
      filtersModel: filtersModel,
    );
  }
}
