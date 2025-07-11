import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:host_visitor_connect/common/data/network/api_services/base_api_service.dart';
import 'package:host_visitor_connect/common/res/keys.dart';
import 'package:host_visitor_connect/common/shared_prefs.dart';
import 'package:host_visitor_connect/features/rentals/data/network/responses/driving_licence_response.dart';

class RentalApiService extends BaseApiService {
  RentalApiService({httpClient}) : super(httpClient);

  Future<DrivingLicenceResponse> drivingLicense({
    required String licenceNo,
    required int? id,
    required String dateOfBirth,
    required String name,
  }) async {
    // Building query
    final uri = getUri('/m/api/getdrivinglicensedetails');

    // Request body
    final body = jsonEncode(
      {
        "aa9": name,
        'drivingNumber': licenceNo,
        'dob': dateOfBirth,
        'aa1': id,
      },
    );
    print(body);
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
    print(response);
    return DrivingLicenceResponse.fromJson(response.data);
  }
}
