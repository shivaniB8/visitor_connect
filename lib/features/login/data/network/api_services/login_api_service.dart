import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:host_visitor_connect/common/data/network/api_services/base_api_service.dart';
import 'package:host_visitor_connect/common/data/network/responses/key_value_response.dart';
import 'package:host_visitor_connect/common/data/network/responses/success_response.dart';
import 'package:host_visitor_connect/common/res/keys.dart';
import 'package:host_visitor_connect/common/shared_prefs.dart';
import 'package:host_visitor_connect/features/login/data/network/response/login_branch_response.dart';
import 'package:host_visitor_connect/features/login/data/network/response/login_response.dart';

class LoginApiService extends BaseApiService {
  LoginApiService({httpClient}) : super(httpClient);

  Future<LoginResponse> loginWithPassword({
    required String phoneNo,
    required String password,
    required int branchId,
    required int reLoginId,
    int? hostId,
  }) async {
    // Building query
    final uri = getUri('/m/api/login');

    // Request body
    final body = jsonEncode(
      {
        "user_id": hostId,
        'login_id': int.parse(phoneNo),
        'login_password': password,
        'ae1': branchId,
        'aq1': reLoginId
      },
    );

    print(body);
    // Building request
    final request = httpClient.post(
      uri.toString(),
      options: getOptions(
        headers: {
          "mobile-type":
              defaultTargetPlatform == TargetPlatform.android ? "1" : "2",
          "user-login-branch": SharedPrefs.getInt(keyBranch) ?? 0,
        },
      ),
      data: body,
    );

    // Sending request
    final response = await send(request);

    if (response.data['success'] == true && response.data['data'] != null) {
      Map<String, dynamic> userData = response.data['data']['user_data'];
      SharedPrefs.setInt(
        keyUserId,
        response.data['data']['user_data']['ad1'],
      );
      SharedPrefs.setInt(
        keyHostFk,
        response.data['data']['user_data']['ad2'],
      );
      String encodedMap = json.encode(userData);
      SharedPrefs.setString(keyUserData, encodedMap);
    }

    return LoginResponse.fromJson(response.data);
  }

  Future<SuccessResponse> forgotPassword({
    required String phoneNo,
  }) async {
    // Building query
    final uri = getUri('/m/api/forgotPassword');

    // Request body
    final body = FormData.fromMap(
      {
        'login_id': phoneNo,
      },
    );
    // Building request
    final request = httpClient.post(
      uri.toString(),
      options: getOptions(
        headers: {
          "mobile-type":
              defaultTargetPlatform == TargetPlatform.android ? "1" : "2",
        },
      ),
      data: body,
    );

    // Sending request
    final response = await send(request);
    return SuccessResponse.fromJson(response.data);
  }

  Future<LoginBranchResponse> loginMobileNumber({
    required String phoneNo,
  }) async {
    List<KeyValueResponse>? data = [];
    // Building query
    final uri = getUri('/m/api/checkLoginMobileNumber');

    // Request body
    final body = FormData.fromMap(
      {
        'login_id': phoneNo,
      },
    );
    // Building request
    final request = httpClient.post(
      uri.toString(),
      options: getOptions(
        headers: {
          "mobile-type":
              defaultTargetPlatform == TargetPlatform.android ? "1" : "2",
        },
      ),
      data: body,
    );

    // Sending request
    final response = await send(request);
    if (response.data['success'] == true && response.data['data'] != null) {
      SharedPrefs.setString(
        keyBucketName,
        response.data["master_bucket_name"] ?? '',
      );
      // GlobalVariable.userName = response.data['data']["ad9"] ?? '';
      // GlobalVariable.userImage = response.data['data']["ad22"] ?? '';
      // var branches = response.data['data']["host_branches_list"];
      // String encodedMap = json.encode(branches);
      // SharedPrefs.setString(keyBranchList, encodedMap);
      // for (var i in response.data['data']["host_branches_list"]) {
      //   data.add(KeyValueResponse.fromJson(i));
      // }
    }
    print(response.data.toString());
    return LoginBranchResponse.fromJson(response.data);
  }

  Future<void> postData({
    required Map<String, dynamic> data,
  }) async {
    // Building query
    final uri = getUri('/m/api/storeFetchedMobileContacts');
    // Request body
    final body = FormData.fromMap(data);
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
      data: body,
    );
    // Sending request
    await send(request);
  }

  Future<SuccessResponse> logout() async {
    final uri = getUri('/m/api/logout');

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
    final response = await send(request);
    return SuccessResponse.fromJson(response.data);
  }
}
