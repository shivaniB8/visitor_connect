import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:host_visitor_connect/common/data/network/api_services/base_api_service.dart';
import 'package:host_visitor_connect/common/data/network/responses/page_response.dart';
import 'package:host_visitor_connect/common/res/keys.dart';
import 'package:host_visitor_connect/common/shared_prefs.dart';
import 'package:host_visitor_connect/features/Filter/data/network/responses/filter_model.dart';
import 'package:host_visitor_connect/features/visitors/history/data/network/responses/visitor_room_response.dart';

class CurrentVisitorApiService extends BaseApiService {
  CurrentVisitorApiService({httpClient}) : super(httpClient);

  Future<PageResponse<VisitorRoomResponse>> currentVisitorsGrouping(
      {final int? pageNo,
      final String? searchTerm,
      final FiltersModel? filterModel,
      int? orderBy = 0}) async {
    // Building query
    final uri = getUri('/m/api/getCurrentVisitorsGroups');

    // Request body
    final body = jsonEncode({
      'aa83': 1,
      "orderBy": orderBy,
      'items_per_page': 50,
      'page_no': pageNo,
      'aa9': searchTerm,
      "aa33": filterModel?.aadharNo,
      "aa25": filterModel?.pincodeFilter,
      "aa11": filterModel?.ageFilter,
      "aa12": filterModel?.genderFilter,
      "age_min": filterModel?.agemin,
      "age_max": filterModel?.agemax,
      "aa39": filterModel?.visaNumber,
      "aa19": filterModel?.stateFk,
      "aa21": filterModel?.cityFk,
      "aa23": filterModel?.areaFk,
      "ae1": SharedPrefs.getInt(keyBranch) ?? 0,
    });

    log("getCurrentVisitorsGroups body : $body");

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

    final response = await send(request);
    log("Current visitor List=> " + response.toString());
    return PageResponse<VisitorRoomResponse>.fromJson(response.data);
  }
}
