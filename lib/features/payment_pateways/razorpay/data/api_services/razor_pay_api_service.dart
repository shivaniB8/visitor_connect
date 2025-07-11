import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:host_visitor_connect/common/data/network/api_services/base_api_service.dart';
import 'package:host_visitor_connect/common/res/keys.dart';
import 'package:host_visitor_connect/common/shared_prefs.dart';
import 'package:host_visitor_connect/features/payment_pateways/razorpay/data/responses/razor_pay_order_response_data.dart';
import 'package:host_visitor_connect/features/payment_pateways/razorpay/data/responses/razor_pay_transaction_response.dart';

class RazorPayApiService extends BaseApiService {
  RazorPayApiService({httpClient}) : super(httpClient);

  Future<RazorPayOrderResponseData> createOrderRazorpay({
    final int? amount,
    final String? reason,
  }) async {
    // Building query
    final uri = getUri('/m/api/createHostRazorpayOrder');
    // Request body
    final body = jsonEncode({
      'total_amount': amount,
      'reason': reason,
    });
    print(body);
    print(getAuthToken());
    print(defaultTargetPlatform == TargetPlatform.android ? "1" : "2");
    print(SharedPrefs.getInt(keyBranch));
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
    return RazorPayOrderResponseData.fromJson(response.data);
  }

  Future<RazorPayTransactionResponse> razorpayPayment({
    final String? transactionId,
  }) async {
    // Building query
    final uri = getUri('/m/api/razorPayPayment');
    // Request body
    final body = jsonEncode({
      'razorpay_payment_id': transactionId,
    });
    print("body razorPayPayment > $body");
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
    return RazorPayTransactionResponse.fromJson(response.data);
  }
}
