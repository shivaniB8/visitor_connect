import 'package:host_visitor_connect/common/data/network/responses/key_value_list_response.dart';
import 'package:host_visitor_connect/common/data/network/responses/page_response.dart';
import 'package:host_visitor_connect/common/data/network/responses/success_response.dart';

import 'package:host_visitor_connect/features/report/report_list/data/network/api_services/report_visitor_api_service.dart';
import 'package:host_visitor_connect/features/report/report_list/data/network/responses/report_list_response.dart';
import 'package:host_visitor_connect/features/Filter/data/network/responses/filter_model.dart';
import 'package:image_picker/image_picker.dart';

class ReportVisitorRepository {
  final ReportVisitorApiService _reportVisitorApiService;

  ReportVisitorRepository({ReportVisitorApiService? reportVisitorApiService})
      : _reportVisitorApiService =
            reportVisitorApiService ?? ReportVisitorApiService();

  Future<SuccessResponse> reportVisitor({
    required Map<String, dynamic> reportVisitorMap,
    XFile? reportPhoto,
  }) {
    return _reportVisitorApiService.reportVisitor(
      reportVisitorMap: reportVisitorMap,
      reportPhoto: reportPhoto,
    );
  }

  Future<KeyValueListResponse> getReasonsList() {
    return _reportVisitorApiService.getReportReasonsList();
  }

  Future<PageResponse<ReportListResponse>> getReportList({
    required int pageNo,
    String? searchTerm,
    FiltersModel? filterModel,
  }) {
    return _reportVisitorApiService.reportList(
        pageNo: pageNo, searchTerm: searchTerm, filtersModel: filterModel);
  }
}
