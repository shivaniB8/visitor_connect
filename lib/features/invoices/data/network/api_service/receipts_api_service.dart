import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:host_visitor_connect/common/data/network/api_services/base_api_service.dart';
import 'package:host_visitor_connect/common/res/keys.dart';
import 'package:host_visitor_connect/common/shared_prefs.dart';
import 'package:host_visitor_connect/features/invoices/data/network/responses/receipt_response.dart';

class ReceiptsApiService extends BaseApiService {
  ReceiptsApiService({httpClient}) : super(httpClient);

  Future<ReceiptResponse> hostPaymentReceipts({final int? pageNo}) async {
    // Building query
    final uri = getUri('/m/api/getHostPaymentReceipt');

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
    );
    // Sending request
    final response = await send(request);
    return ReceiptResponse.fromJson(response.data);
  }
}
