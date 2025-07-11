import 'package:host_visitor_connect/common/data/network/responses/page_response.dart';
import 'package:host_visitor_connect/features/report/report_history/data/network/api_services/report_history_api_service.dart';
import 'package:host_visitor_connect/features/report/report_list/data/network/responses/report_list_response.dart';

class ReportHistoryRepository {
  final ReportHistoryApiService _reportHistoryApiService;

  ReportHistoryRepository({ReportHistoryApiService? reportHistoryApiService})
      : _reportHistoryApiService =
            reportHistoryApiService ?? ReportHistoryApiService();

  Future<PageResponse<ReportListResponse>> getReportList({
    required int pageNo,
    required int visitorId,
  }) {
    return _reportHistoryApiService.reportHistoryListing(
        pageNo: pageNo, visitorId: visitorId);
  }
}
