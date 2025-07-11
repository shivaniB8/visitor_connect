import 'package:host_visitor_connect/common/data/network/responses/page_response.dart';
import 'package:host_visitor_connect/features/visitors/history/data/network/api_services/visitor_history_api_service.dart';
import 'package:host_visitor_connect/features/visitors/history/data/network/responses/visitor_history_response.dart';

class VisitorHistoryRepository {
  final VisitorHistoryApiService _visitorHistoryApiService;

  VisitorHistoryRepository({VisitorHistoryApiService? visitorHistoryApiService})
      : _visitorHistoryApiService =
            visitorHistoryApiService ?? VisitorHistoryApiService();

  Future<PageResponse<VisitorHistoryResponse>> getVisitorHistoryListing({
    required int pageNo,
    required int visitorId,
  }) {
    return _visitorHistoryApiService.visitorHistoryListing(
      pageNo: pageNo,
      visitorId: visitorId,
    );
  }
}
