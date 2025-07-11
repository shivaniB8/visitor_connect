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
import 'package:host_visitor_connect/features/visitors/add_visitor/data/network/response/add_foreigner_visitor_response.dart';
import 'package:host_visitor_connect/features/visitors/add_visitor/data/network/response/check_mobile_response.dart';
import 'package:host_visitor_connect/features/visitors/add_visitor/data/network/response/otp_generation_response.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_plus/share_plus.dart';

class AddVisitorApiServices extends BaseApiService {
  AddVisitorApiServices({httpClient}) : super(httpClient);

  Future<AddForeignerVisitorResponse> addForeignerVisitorManually({
    required Map<String, dynamic> foreignerVisitor,
    required XFile passportFirstPhoto,
    required XFile passportLastPhoto,
    required XFile visaPhoto,
    required XFile profilePhoto,
  }) async {
    // Building query
    final uri = getUri('m/api/addVisitorManually');
    final requestOptions = getOptions(
      headers: {
        HttpHeaders.authorizationHeader: "Bearer ${getAuthToken()}",
        "client": SharedPrefs.getInt(keyClientId),
        "mobile-type":
            defaultTargetPlatform == TargetPlatform.android ? "1" : "2",
        "user": SharedPrefs.getString(keyUserData),
        "user-login-branch": SharedPrefs.getInt(keyBranch) ?? 0,
      },
    );
    // Request body
    final body = FormData.fromMap(foreignerVisitor);
    if (!(profilePhoto.path.isNullOrEmpty())) {
      log("aa15 > ${profilePhoto.path}");
      body.files.add(
        MapEntry(
          'aa15',
          MultipartFile.fromFileSync(
            profilePhoto.path,
          ),
        ),
      );
    }
    if (!(passportFirstPhoto.path.isNullOrEmpty())) {
      log("aa66 > ${passportFirstPhoto.path}");
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
      log("aa75 > ${visaPhoto.path}");
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
      log("aa75 > ${visaPhoto.path}");
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
    return AddForeignerVisitorResponse.fromJson(response.data);
  }

  Future<CheckMobileResponse> checkMobileNumber({
    required String mobileNo,
  }) async {
    // Building query
    final uri = getUri('m/api/getvisitorusingcontact');
    final requestOptions = getOptions(
      headers: {
        HttpHeaders.authorizationHeader: "Bearer ${getAuthToken()}",
        "client": SharedPrefs.getInt(keyClientId),
        "mobile-type":
            defaultTargetPlatform == TargetPlatform.android ? "1" : "2",
        "user": SharedPrefs.getString(keyUserData),
        "user-login-branch": SharedPrefs.getInt(keyBranch) ?? 0,
      },
    );

    // Request body
    final body = jsonEncode({"aa13": mobileNo});

    // Building request
    final request = httpClient.post(
      uri.toString(),
      options: requestOptions,
      data: body,
    );

    // Sending request
    final response = await send(request);
    return CheckMobileResponse.fromJson(response.data);
  }

  Future<OtpGenerationResponse> requestOtp({
    String? mobileNo,
    String? aadharNo,
    int? update,
    int? id,
  }) async {
    // Building query

    final uri = getUri('/m/api/generateaadharotp');

    // Request body
    final body = jsonEncode({
      "aadhar_number": aadharNo,
      "aa13": mobileNo,
      "update": update,
      "aa1": id == 0 ? 0 : id,
    });

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
    final response = await send(request);
    return OtpGenerationResponse.fromJson(response.data);
  }

  Future<OtpGenerationResponse> getAadharDetails({
    required String mobileNo,
    required String aadharNo,
    required int update,
    required int id,
    required String otp,
  }) async {
    // Building query
    final uri = getUri('/m/api/getaadharcarddetails');

    // Request body
    final body = jsonEncode({
      "aadhar_number": aadharNo,
      "aa13": mobileNo,
      "update": update,
      "aa1": id == 0 ? 0 : id,
      "otp": otp,
    });

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
    print("getaadharcarddetails");
    print(body);
    // Sending request
    final response = await send(request);
    return OtpGenerationResponse.fromJson(response.data);
  }

  Future<KeyValueListResponse> getReasonToVisit() async {
    final uri = getUri('/m/api/common/getVisitingReason');

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

  Future<SuccessResponse> updateVisitorInfo({
    required Map<String, dynamic> indianVisitorInfo,
  }) async {
    // Building query
    final uri = getUri('/m/api/updateVisitorVisitingInfo');
    final requestOptions = getOptions(
      headers: {
        HttpHeaders.authorizationHeader: "Bearer ${getAuthToken()}",
        "client": SharedPrefs.getInt(keyClientId),
        "mobile-type":
            defaultTargetPlatform == TargetPlatform.android ? "1" : "2",
        "user": SharedPrefs.getString(keyUserData),
        "user-login-branch": SharedPrefs.getInt(keyBranch) ?? 0,
      },
    );

    // Request body
    final body = indianVisitorInfo;
    print("-------------------------");
    print(body);

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

  Future<SuccessResponse> visitorDocuments({
    XFile? aadharFront,
    XFile? aadharBack,
    required int visitorId,
  }) async {
    final uri = getUri('/m/api/uploadVisitorAadharDocument');
    final body = FormData.fromMap({
      'aa1': visitorId,
    });

    if ((aadharFront?.path.isNotEmpty ?? false)) {
      body.files.add(
        MapEntry(
          'aa50',
          MultipartFile.fromFileSync(
            aadharFront?.path ?? "",
          ),
        ),
      );
    }

    if ((aadharBack?.path.isNotEmpty ?? false)) {
      body.files.add(
        MapEntry(
          'aa51',
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

  Future<SuccessResponse> drivingLicenceDocuments({
    XFile? licenceFront,
    XFile? licenceBack,
    required int visitorId,
  }) async {
    final uri = getUri('/m/api/uploadVisitorDrivingLicence');
    final body = FormData.fromMap({
      'aa1': visitorId,
    });

    if ((licenceFront?.path.isNotEmpty ?? false)) {
      body.files.add(
        MapEntry(
          'aa54',
          MultipartFile.fromFileSync(
            licenceFront?.path ?? "",
          ),
        ),
      );
    }

    print(body.fields);
    print("uploadVisitorAadharDocument");
    // if ((licenceBack?.path.isNotEmpty ?? false)) {
    //   body.files.add(
    //     MapEntry(
    //       'aa55',
    //       MultipartFile.fromFileSync(
    //         licenceBack?.path ?? "",
    //       ),
    //     ),
    //   );
    // }

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
    return SuccessResponse.fromJson(response.data);
  }

  Future<KeyValueListResponse> getBloodGrps() async {
    final uri = getUri('m/api/common/getbloodgroups');

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
}
