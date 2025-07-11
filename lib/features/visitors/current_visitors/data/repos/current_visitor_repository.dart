import 'package:host_visitor_connect/common/data/network/responses/page_response.dart';
import 'package:host_visitor_connect/features/Filter/data/network/responses/filter_model.dart';
import 'package:host_visitor_connect/features/visitors/current_visitors/data/network/api_service/current_visitors_api_service.dart';
import 'package:host_visitor_connect/features/visitors/history/data/network/responses/visitor_room_response.dart';

class CurrentVisitorRepository {
  final CurrentVisitorApiService _visitorApiService;

  CurrentVisitorRepository({CurrentVisitorApiService? visitorApiService})
      : _visitorApiService = visitorApiService ?? CurrentVisitorApiService();

  Future<PageResponse<VisitorRoomResponse>> currentVisitorsGrouping({
    required int pageNo,
    String? searchTerm,
    FiltersModel? filterModel,
    int? orderBy,
  }) {
    return _visitorApiService.currentVisitorsGrouping(
        pageNo: pageNo,
        searchTerm: searchTerm,
        filterModel: filterModel,
        orderBy: orderBy);
  }
}
