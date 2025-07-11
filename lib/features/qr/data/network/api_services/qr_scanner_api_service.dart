import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:host_visitor_connect/common/data/network/api_services/base_api_service.dart';
import 'package:host_visitor_connect/common/data/network/responses/success_response.dart';
import 'package:host_visitor_connect/common/extensions/string_extensions.dart';
import 'package:host_visitor_connect/common/res/keys.dart';
import 'package:host_visitor_connect/common/shared_prefs.dart';
import 'package:host_visitor_connect/features/qr/data/network/responses/qr_scanner_response.dart';
import 'package:image_picker/image_picker.dart';

class QrScannerApiService extends BaseApiService {
  QrScannerApiService({httpClient}) : super(httpClient);

  Future<QrScannerResponse> getDataFromQr({
    required int visitorId,
    required String aadhar,
    int? allowToScan,
    required int businessType,
  }) async {
    // Building query
    final uri = getUri('/m/api/scanVisitor');

    // Request body
    final body = jsonEncode(
      {
        'aa1': visitorId,
        'allowToScan': allowToScan,
        'hostBusinessType': businessType,
      },
    );

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
    // log("ScanQR=> "+response.toString());
    return QrScannerResponse.fromJson(response.data);
  }

  Future<SuccessResponse> faceMatch({
    required int visitorId,
    required XFile profilePhoto,
    required String aadhaarPhoto,
  }) async {
    print(aadhaarPhoto);
    // Building query
    final uri = getUri('/m/api/getVisitorFaceMatchDetails');

    // Request body

    final body = FormData.fromMap({
      'aa1': visitorId,
      "visitor_aadhar_photo": aadhaarPhoto,
    });
    if (!(profilePhoto.path.isNullOrEmpty())) {
      body.files.add(
        MapEntry(
          'visitor_photo',
          MultipartFile.fromFileSync(
            profilePhoto.path,
          ),
        ),
      );
    }

    print(body.files);
    print(body.fields);
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
    // log("ScanQR=> "+response.toString());
    return SuccessResponse.fromJson(response.data);
  }
}
