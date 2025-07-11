import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:host_visitor_connect/common/data/network/api_services/base_api_service.dart';
import 'package:host_visitor_connect/common/data/network/responses/key_value_list_response.dart';
import 'package:host_visitor_connect/common/data/network/responses/page_response.dart';
import 'package:host_visitor_connect/common/data/network/responses/success_response.dart';
import 'package:host_visitor_connect/common/extensions/string_extensions.dart';
import 'package:host_visitor_connect/common/res/keys.dart';
import 'package:host_visitor_connect/common/shared_prefs.dart';
import 'package:host_visitor_connect/features/report/report_list/data/network/responses/report_list_response.dart';
import 'package:host_visitor_connect/features/Filter/data/network/responses/filter_model.dart';
import 'package:image_picker/image_picker.dart';

class ReportVisitorApiService extends BaseApiService {
  ReportVisitorApiService({httpClient}) : super(httpClient);

  Future<SuccessResponse> reportVisitor({
    required Map<String, dynamic> reportVisitorMap,
    XFile? reportPhoto,
  }) async {
    // Building query
    final uri = getUri('m/api/reportVisitor');
    final requestOptions = getOptions(
      headers: {
        HttpHeaders.authorizationHeader: "Bearer ${getAuthToken()}",
        "mobile-type":
            defaultTargetPlatform == TargetPlatform.android ? "1" : "2",
        "user": SharedPrefs.getString(keyUserData),
        "client": SharedPrefs.getInt(keyClientId),
        "user-login-branch": SharedPrefs.getInt(keyBranch) ?? 0,
      },
    );

    final body = FormData.fromMap(reportVisitorMap);
    if (!(reportPhoto?.path.isNullOrEmpty() ?? false)) {
      body.files.add(
        MapEntry(
          'aw11',
          MultipartFile.fromFileSync(
            reportPhoto!.path,
          ),
        ),
      );
    }
    final request = httpClient.post(
      uri.toString(),
      options: requestOptions,
      data: body,
    );
    final response = await send(request);
    return SuccessResponse.fromJson(response.data);
  }

  Future<KeyValueListResponse> getReportReasonsList() async {
    // Building query
    final uri = getUri('/m/api/common/getReportReasonsList');

    // Building request
    final request = httpClient.post(
      uri.toString(),
      options: getOptions(
        headers: {
          HttpHeaders.authorizationHeader: "Bearer ${getAuthToken()}",
          "client": SharedPrefs.getInt(keyClientId),
          "mobile-type":
              defaultTargetPlatform == TargetPlatform.android ? "1" : "2",
          "user": SharedPrefs.getString(keyUserData),
          "user-login-branch":
          SharedPrefs.getInt(keyBranch) ?? 0,
        },
      ),
    );

    // Sending request
    final response = await send(request);
    return KeyValueListResponse.fromJson(response.data);
  }

  Future<PageResponse<ReportListResponse>> reportList(
      {final int? pageNo,
      FiltersModel? filtersModel,
      String? searchTerm}) async {
    // Building query
    final uri = getUri('/m/api/getVisitorReports');

    // Request body
    final body = jsonEncode({
      'items_per_page': 50,
      'page_no': pageNo,
      'aa9': searchTerm,
      "aa33": filtersModel?.aadharNo,
      "aa25": filtersModel?.pincodeFilter,
      "aa11": filtersModel?.ageFilter,
      "aa12": filtersModel?.genderFilter,
      "age_min": filtersModel?.agemin,
      "age_max": filtersModel?.agemax,
      "aa39": filtersModel?.visaNumber,
      "aa19": filtersModel?.stateFk,
      "aa21": filtersModel?.cityFk,
      "aa23": filtersModel?.areaFk
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
          "user-login-branch":
          SharedPrefs.getInt(keyBranch) ?? 0,
        },
      ),
      data: body,
    );
    // Sending request
    final response = await send(request);
    return PageResponse<ReportListResponse>.fromJson(response.data);
  }
}
