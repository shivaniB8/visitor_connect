import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:host_visitor_connect/common/data/network/api_services/base_api_service.dart';
import 'package:host_visitor_connect/common/data/network/responses/key_value_list_response.dart';

import 'package:host_visitor_connect/common/res/keys.dart';
import 'package:host_visitor_connect/common/shared_prefs.dart';

class GetFiltersApiServices extends BaseApiService {
  GetFiltersApiServices({httpClient}) : super(httpClient);

  Future<KeyValueListResponse> getStates() async {
    final uri = getUri('m/api/common/getstates');

    final request = httpClient.post(
      uri.toString(),
      options: getOptions(
        headers: {
          'Authorization': 'Bearer ${getAuthToken()}',
          "client": SharedPrefs.getInt(keyClientId),
          "mobile-type":
              defaultTargetPlatform == TargetPlatform.android ? "1" : "2",
          "user": SharedPrefs.getString(keyUserData),
        },
      ),
    );

    final response = await send(request);

    return KeyValueListResponse.fromJson(response.data);
  }

  Future<KeyValueListResponse> getCity({required int? stateValue}) async {
    final uri = getUri('m/api/common/getcities');
    final body = jsonEncode(
      {
        'state_id': stateValue,
      },
    );
    final request = httpClient.post(
      uri.toString(),
      options: getOptions(
        headers: {
          'Authorization': 'Bearer ${getAuthToken()}',
          "client": SharedPrefs.getInt(keyClientId),
          "mobile-type":
              defaultTargetPlatform == TargetPlatform.android ? "1" : "2",
          "user": SharedPrefs.getString(keyUserData),
        },
      ),
      data: body,
    );

    final response = await send(request);

    return KeyValueListResponse.fromJson(response.data);
  }

  Future<KeyValueListResponse> getArea({required int? cityValue}) async {
    final uri = getUri('m/api/common/getareas');
    final body = jsonEncode(
      {
        'city_id': cityValue,
      },
    );
    final request = httpClient.post(
      uri.toString(),
      options: getOptions(
        headers: {
          'Authorization': 'Bearer ${getAuthToken()}',
          "client": SharedPrefs.getInt(keyClientId),
          "mobile-type":
              defaultTargetPlatform == TargetPlatform.android ? "1" : "2",
          "user": SharedPrefs.getString(keyUserData),
        },
      ),
      data: body,
    );

    final response = await send(request);

    return KeyValueListResponse.fromJson(response.data);
  }
}
