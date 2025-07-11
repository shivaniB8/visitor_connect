import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:host_visitor_connect/common/data/network/api_services/base_api_service.dart';
import 'package:host_visitor_connect/common/data/network/responses/page_response.dart';
import 'package:host_visitor_connect/common/res/keys.dart';
import 'package:host_visitor_connect/common/shared_prefs.dart';
import 'package:host_visitor_connect/features/users/users_listing/data/network/response/users_data_response.dart';
import 'package:host_visitor_connect/features/Filter/data/network/responses/filter_model.dart';

class UsersListingApiService extends BaseApiService {
  UsersListingApiService({httpClient}) : super(httpClient);

  Future<PageResponse<UsersDataResponse>> usersListing({
    final int? pageNo,
    final String? searchTerm,
    final FiltersModel? filtersModel,
  }) async {
    // Building query

    final uri = getUri('/m/api/getUserList');

    // Request body
    final body = jsonEncode({
      'items_per_page': 50,
      'page_no': pageNo,
      'user_name': searchTerm,
      'ad44': filtersModel?.userStatus,
    });
    print(body);
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
    return PageResponse<UsersDataResponse>.fromJson(response.data);
  }
}
