import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:host_visitor_connect/common/data/network/api_services/base_api_service.dart';
import 'package:host_visitor_connect/common/data/network/responses/key_value_list_response.dart';
import 'package:host_visitor_connect/common/data/network/responses/success_response.dart';
import 'package:host_visitor_connect/common/extensions/string_extensions.dart';
import 'package:host_visitor_connect/common/res/keys.dart';
import 'package:host_visitor_connect/common/shared_prefs.dart';
import 'package:host_visitor_connect/features/dashboard/data/network/responses/user_details_response.dart';
import 'package:host_visitor_connect/features/profile/data/network/responses/update_profile_response.dart';
import 'package:image_picker/image_picker.dart';

class UserApiService extends BaseApiService {
  UserApiService({httpClient}) : super(httpClient);

  Future<UserDetailsResponse> userDetails() async {
    // Building query
    final uri = getUri('/m/api/getUserById');

    // Request body
    final body = jsonEncode({'ad1': SharedPrefs.getInt(keyUserId)});

    // Building request
    final request = httpClient.post(
      uri.toString(),
      options: getOptions(
        headers: {
          'Authorization': 'Bearer ${getAuthToken()}',
          "client": SharedPrefs.getInt(keyClientId),
          "mobile-type":
              defaultTargetPlatform == TargetPlatform.android ? "1" : "2",
          'user': SharedPrefs.getString(keyUserData),
          "user-login-branch": SharedPrefs.getInt(keyBranch) ?? 0,
        },
      ),
      data: body,
    );
    print("userDetails");
    print(body);

    // Sending request
    final response = await send(request);
    if (response.data['status'] == 200) {
      return UserDetailsResponse.fromJson(response.data?['data']);
    }
    return UserDetailsResponse.fromJson(response.data);
  }

  Future<SuccessResponse> resetPassword({
    required String newPassword,
    required String oldPassword,
    required String confirmPassword,
  }) async {
    // Building query
    final uri = getUri('m/api/resetPassword');

    // Request body
    final body = jsonEncode(
      {
        'ad1': SharedPrefs.getInt(keyUserId),
        "password": newPassword,
        "password_confirmation": confirmPassword,
        "old_password": oldPassword
      },
    );

    // Building request
    final request = httpClient.post(
      uri.toString(),
      options: getOptions(
        headers: {
          'Authorization': 'Bearer ${getAuthToken()}',
          "client": SharedPrefs.getInt(keyClientId),
          "mobile-type":
              defaultTargetPlatform == TargetPlatform.android ? "1" : "2",
          'user': SharedPrefs.getString(keyUserData),
        },
      ),
      data: body,
    );

    // Sending request
    final response = await send(request);
    return SuccessResponse.fromJson(response.data);
  }

  Future<UpdateProfileResponse> updateUserDetails({
    required Map<String, dynamic> userUpdatedData,
    XFile? profilePhoto,
  }) async {
    // Building query

    final uri = getUri('/m/api/updateUserProfile');
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
    final body = FormData.fromMap(userUpdatedData);
    log("updateUserProfile body > $body");
    if (!(profilePhoto?.path.isNullOrEmpty() ?? false)) {
      body.files.add(
        MapEntry(
          'userProfileImage',
          MultipartFile.fromFileSync(
            profilePhoto!.path,
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
    return UpdateProfileResponse.fromJson(response.data);
  }

  Future<KeyValueListResponse> getBranches() async {
    final uri = getUri('/m/api/common/getHostBranches');

    final body = jsonEncode(
      {
        'ac1': SharedPrefs.getInt(keyHostFk),
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
          "user-login-branch": SharedPrefs.getInt(keyBranch) ?? 0,
        },
      ),
      data: body,
    );

    final response = await send(request);
    return KeyValueListResponse.fromJson(response.data);
  }

  Future<KeyValueListResponse> getTitles() async {
    final uri = getUri('/m/api/common/getalltitle');

    final request = httpClient.post(
      uri.toString(),
      options: getOptions(
        headers: {
          'Authorization': 'Bearer ${getAuthToken()}',
          "client": SharedPrefs.getInt(keyClientId),
          "mobile-type":
              defaultTargetPlatform == TargetPlatform.android ? "1" : "2",
          "user": SharedPrefs.getString(keyUserData),
          "user-login-branch": SharedPrefs.getInt(keyBranch) ?? 0,
        },
      ),
    );

    final response = await send(request);
    return KeyValueListResponse.fromJson(response.data);
  }

  Future<SuccessResponse> userDocuments({
    XFile? aadharFront,
    XFile? aadharBack,
  }) async {
    final uri = getUri('/m/api/uploadUserDocuments');

    final body = FormData.fromMap({'ax7': 1, 'ax8': 'Aadhar'});
    if (!(aadharFront?.path.isNullOrEmpty() ?? false)) {
      body.files.add(
        MapEntry(
          'ax5',
          MultipartFile.fromFileSync(
            aadharFront?.path ?? "",
          ),
        ),
      );
    }
    if (!(aadharBack?.path == null || (aadharBack?.path.isEmpty ?? false))) {
      body.files.add(
        MapEntry(
          'ax9',
          MultipartFile.fromFileSync(
            aadharBack?.path ?? "",
          ),
        ),
      );
    }
    final request = httpClient.post(
      uri.toString(),
      options: getOptions(
        headers: {
          'Authorization': 'Bearer ${getAuthToken()}',
          "client": SharedPrefs.getInt(keyClientId),
          "mobile-type":
              defaultTargetPlatform == TargetPlatform.android ? "1" : "2",
          "user": SharedPrefs.getString(keyUserData),
          "user-login-branch": SharedPrefs.getInt(keyBranch) ?? 0,
        },
      ),
      data: body,
    );

    final response = await send(request);

    return SuccessResponse.fromJson(response.data);
  }

  Future<SuccessResponse> deleteAccount() async {
    final uri = getUri('m/api/deleteUserAccount');

    final body = jsonEncode(
      {
        'userId': SharedPrefs.getInt(keyUserId),
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
          "user-login-branch": SharedPrefs.getInt(keyBranch) ?? 0,
        },
      ),
      data: body,
    );

    final response = await send(request);
    return SuccessResponse.fromJson(response.data);
  }
}
