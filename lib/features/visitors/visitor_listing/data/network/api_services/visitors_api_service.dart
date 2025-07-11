import 'dart:convert';
import 'dart:developer';

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
import 'package:host_visitor_connect/features/visitors/history/data/network/responses/visitor_room_response.dart';
import 'package:host_visitor_connect/features/visitors/visitor_listing/data/network/responses/check_out_response.dart';
import 'package:host_visitor_connect/features/visitors/visitor_listing/data/network/responses/outgoing_call_response.dart';
import 'package:host_visitor_connect/features/visitors/visitor_listing/data/network/responses/virtual_number_response.dart';
import 'package:host_visitor_connect/features/visitors/visitor_listing/data/network/responses/visitor_details_response.dart';
import 'package:host_visitor_connect/features/Filter/data/network/responses/filter_model.dart';
import 'package:image_picker/image_picker.dart';

class VisitorApiService extends BaseApiService {
  VisitorApiService({httpClient}) : super(httpClient);

  Future<PageResponse<VisitorDetailsResponse>> visitorListing({
    final int? pageNo,
    final String? searchTerm,
    final FiltersModel? filterModel,
  }) async {
    // Building query
    final uri = getUri('/m/api/getHostVisitorHistoryList');

    // Request body
    final body = jsonEncode({
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
    final response = await send(request);
    return PageResponse<VisitorDetailsResponse>.fromJson(response.data);
  }

  Future<KeyValueListResponse> getCountryList() async {
    // Building query
    final uri = getUri('m/api/common/getCountryList');

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
          "user-login-branch": SharedPrefs.getInt(keyBranch) ?? 0,
        },
      ),
    );

    // Sending request
    final response = await send(request);
    return KeyValueListResponse.fromJson(response.data);
  }

  Future<SuccessResponse> updateVisitorsDetails({
    required Map<String, dynamic> visitorsUpdatedData,
    XFile? profilePhoto,
    required XFile passportFirstPhoto,
    required XFile passportLastPhoto,
    required XFile visaPhoto,
  }) async {
    // Building query
    final uri = getUri('/m/api/updateVisitorManually');
    final requestOptions = getOptions(
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: "Bearer ${getAuthToken()}",
        "client": SharedPrefs.getInt(keyClientId),
        "mobile-type":
            defaultTargetPlatform == TargetPlatform.android ? "1" : "2",
        "user": SharedPrefs.getString(keyUserData),
        "user-login-branch": SharedPrefs.getInt(keyBranch) ?? 0,
      },
    );

    // Request body
    final body = FormData.fromMap(visitorsUpdatedData);
    print(body);
    print(visitorsUpdatedData);
    if (!(profilePhoto?.path.isNullOrEmpty() ?? false)) {
      body.files.add(
        MapEntry(
          'visitorProfileImage',
          MultipartFile.fromFileSync(
            profilePhoto!.path,
          ),
        ),
      );
    }
    if (!(passportFirstPhoto.path.isNullOrEmpty())) {
      body.files.add(
        MapEntry(
          'aa66',
          MultipartFile.fromFileSync(
            passportFirstPhoto.path,
          ),
        ),
      );
    }
    if (!(visaPhoto.path.isNullOrEmpty())) {
      body.files.add(
        MapEntry(
          'aa75',
          MultipartFile.fromFileSync(
            visaPhoto.path,
          ),
        ),
      );
    }
    if (!(passportLastPhoto.path.isNullOrEmpty())) {
      body.files.add(
        MapEntry(
          'aa77',
          MultipartFile.fromFileSync(
            passportLastPhoto.path,
          ),
        ),
      );
    }
    // Building request
    final request = httpClient.post(
      uri.toString(),
      options: requestOptions,
      data: body,
    );

    // Sending request
    final response = await send(request);
    return SuccessResponse.fromJson(response.data);
  }

  Future<VirtualNumberResponse> getVirtualNumbers() async {
    // Building query
    final uri = getUri('m/api/getvirtualnumberslist');

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
          "user-login-branch": SharedPrefs.getInt(keyBranch) ?? 0,
        },
      ),
    );

    // Sending request
    final response = await send(request);
    return VirtualNumberResponse.fromJson(response.data);
  }

  Future<CheckOutResponse> visitorCheckout({
    final int? visitorId,
    final String? checkOutDate,
    final String? checkOutTime,
  }) async {
    // Building query
    final uri = getUri('/m/api/checkOutVisitor');

    // Request body
    final body = jsonEncode({
      'ab1': visitorId,
      'ab7': "$checkOutDate $checkOutTime",
      // {
      //   'checkOutDate': checkOutDate, // Include checkOutDate
      //   'checkOutTime': checkOutTime, // Include checkOutTime
      // },
    });
    log("Checkout data > $body");
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

    log("Checkout resp > $response");
    return CheckOutResponse.fromJson(response.data);
  }

  Future<OutgoingCallResponse> outgoingCall({
    required int visitorId,
    required int settingId,
  }) async {
    // Building query
    final uri = getUri('m/api/outgoingcall');

    // Request body
    final body = jsonEncode(
      {
        'settingId': settingId,
        'visitorid': visitorId,
      },
    );

    // Building request
    final request = httpClient.post(
      uri.toString(),
      data: body,
      options: getOptions(
        headers: {
          HttpHeaders.authorizationHeader: "Bearer ${getAuthToken()}",
          "client": SharedPrefs.getInt(keyClientId),
          "mobile-type":
              defaultTargetPlatform == TargetPlatform.android ? "1" : "2",
          "user": SharedPrefs.getString(keyUserData),
          "user-login-branch": SharedPrefs.getInt(keyBranch) ?? 0,
        },
      ),
    );

    // Sending request
    final response = await send(request);
    return OutgoingCallResponse.fromJson(jsonDecode(response.data));
  }

  Future<PageResponse<VisitorRoomResponse>> visitorsGrouping({
    final int? pageNo,
    final String? searchTerm,
    final FiltersModel? filterModel,
    final int? orderBy = 0,
  }) async {
    // Building query
    final uri = getUri('/m/api/getVisitorsGroups');

    // Request body
    final body = jsonEncode({
      'aa83': 1,
      'orderBy': orderBy,
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

    log("/getVisitorsGroups body: $body");
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

    return PageResponse<VisitorRoomResponse>.fromJson(response.data);
  }
}
