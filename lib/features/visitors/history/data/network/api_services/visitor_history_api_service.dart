import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:host_visitor_connect/common/data/network/api_services/base_api_service.dart';
import 'package:host_visitor_connect/common/data/network/responses/page_response.dart';
import 'package:host_visitor_connect/common/res/keys.dart';
import 'package:host_visitor_connect/common/shared_prefs.dart';
import 'package:host_visitor_connect/features/visitors/history/data/network/responses/visitor_history_response.dart';

class VisitorHistoryApiService extends BaseApiService {
  VisitorHistoryApiService({httpClient}) : super(httpClient);

  Future<PageResponse<VisitorHistoryResponse>> visitorHistoryListing({
    final int? pageNo,
    final int? visitorId,
  }) async {
    // Building query
    final uri = getUri('/m/api/getVisitorHistoryById');

    // Request body
    final body = jsonEncode({
      'items_per_page': 50,
      'page_no': pageNo,
      "visitor_id": visitorId,
      "ae1": SharedPrefs.getInt(keyBranch) ?? 0,
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
    return PageResponse<VisitorHistoryResponse>.fromJson(response.data);
  }
}
