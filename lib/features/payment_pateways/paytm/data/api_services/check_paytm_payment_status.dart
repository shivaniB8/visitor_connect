import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:host_visitor_connect/common/data/network/api_services/base_api_service.dart';
import 'package:host_visitor_connect/common/res/keys.dart';
import 'package:host_visitor_connect/common/shared_prefs.dart';
import 'package:host_visitor_connect/features/payment_pateways/paytm/data/models/paytm_payment_status_resp.dart';

class CheckPaytmPaymentStatusApiService extends BaseApiService {
  CheckPaytmPaymentStatusApiService({httpClient}) : super(httpClient);

  Future<CheckPaytmPaymentStatusResponse> generateCheckPaytmPaymentStatusToken(
      {final String? orderId}) async {
    // Building query
    final uri = getUri('/m/api/paytmSuccess');
    // Request body
    final body = jsonEncode(
        {'ORDERID': orderId, "BANKTXNID": "", "PAYMENTMODE": "", "STATUS": ""});
    print("body : $body");
    print("getAuthToken : ${getAuthToken()}");
    print(defaultTargetPlatform == TargetPlatform.android ? "1" : "2");
    print("keyBranch : ${SharedPrefs.getInt(keyBranch)}");
    print("user : ${SharedPrefs.getString(keyUserData)}");
    // Building request
    final request = httpClient.post(
      uri.toString(),
      options: getOptions(
        headers: {
          HttpHeaders.authorizationHeader: "Bearer ${getAuthToken()}",
          "mobile-type":
              defaultTargetPlatform == TargetPlatform.android ? "1" : "2",
          "user": SharedPrefs.getString(keyUserData),
          "client": 1,
          "user-login-branch": SharedPrefs.getInt(keyBranch) ?? 0,
        },
      ),
      data: body,
    );

    // Sending request
    final response = await send(request);
    print("response paytm status > ${response}");
    return CheckPaytmPaymentStatusResponse.fromJson(json.decode(response.data));
  }
}
