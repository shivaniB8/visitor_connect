import 'package:host_visitor_connect/common/data/network/responses/page_response.dart';
import 'package:host_visitor_connect/features/Filter/data/network/responses/filter_model.dart';
import 'package:host_visitor_connect/features/rent/rented_listing/data/network/rent_api_services.dart';
import 'package:host_visitor_connect/features/visitors/history/data/network/responses/visitor_room_response.dart';

class RentedListingRepository {
  final RentApiService _rentApiService;

  RentedListingRepository({RentApiService? rentApiService})
      : _rentApiService = rentApiService ?? RentApiService();

  Future<PageResponse<VisitorRoomResponse>> rentedListing({
    required int pageNo,
    String? searchTerm,
    FiltersModel? filterModel,
    int? orderBy,
  }) {
    return _rentApiService.rentedListing(
      pageNo: pageNo,
      searchTerm: searchTerm,
      filterModel: filterModel,
      orderBy: orderBy,
    );
  }
}
