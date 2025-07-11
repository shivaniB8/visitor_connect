import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:host_visitor_connect/common/data/network/api_services/base_api_service.dart';
import 'package:host_visitor_connect/common/data/network/responses/page_response.dart';
import 'package:host_visitor_connect/common/res/keys.dart';
import 'package:host_visitor_connect/common/shared_prefs.dart';
import 'package:host_visitor_connect/features/report/report_list/data/network/responses/report_list_response.dart';

class ReportHistoryApiService extends BaseApiService {
  ReportHistoryApiService({httpClient}) : super(httpClient);

  Future<PageResponse<ReportListResponse>> reportHistoryListing({
    final int? pageNo,
    final int? visitorId,
  }) async {
    // Building query
    final uri = getUri('/m/api/getVisitorReportsHistory');

    // Request body
    final body = jsonEncode({
      'items_per_page': 50,
      'page_no': pageNo,
      'aa1': visitorId,
    });

    // Building request
    final request = httpClient.post(
      uri.toString(),
      options: getOptions(
        headers: {
          HttpHeaders.authorizationHeader: "Bearer ${getAuthToken()}",
          "mobile-type":
              defaultTargetPlatform == TargetPlatform.android ? "1" : "2",
          "user": SharedPrefs.getString(keyUserData),
          "client": SharedPrefs.getInt(keyClientId),
          "user-login-branch": SharedPrefs.getInt(keyBranch) ?? 0,
        },
      ),
      data: body,
    );
    // Sending request
    final response = await send(request);
    return PageResponse<ReportListResponse>.fromJson(response.data);
  }
}
