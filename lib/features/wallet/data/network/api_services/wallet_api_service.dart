import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:host_visitor_connect/common/data/network/api_services/base_api_service.dart';
import 'package:host_visitor_connect/common/data/network/responses/page_response.dart';
import 'package:host_visitor_connect/common/res/keys.dart';
import 'package:host_visitor_connect/common/shared_prefs.dart';
import 'package:host_visitor_connect/features/wallet/data/network/responses/bar_graph_resp.dart';
import 'package:host_visitor_connect/features/wallet/data/network/responses/wallet_statement_listing_response.dart';
import 'package:host_visitor_connect/features/wallet/ui/model/wallet_filters_model.dart';

class WalletApiService extends BaseApiService {
  WalletApiService({httpClient}) : super(httpClient);

  Future<PageResponse<WalletStatementListingResponse>> hostAccountStatement({
    final int? pageNo,
    WalletFiltersModel? walletFiltersModel,
  }) async {
    // Building query
    final uri = getUri('/m/api/getHostAccountStatement');
    // Request body
    final body = jsonEncode({
      'items_per_page': 30,
      'page_no': pageNo,
      'hg3': walletFiltersModel?.transactionType,
      // 'fromdate': walletFiltersModel?.fromDate,
      // 'todate': walletFiltersModel?.toDate,
      'year': walletFiltersModel?.year,
      'month': walletFiltersModel?.month
    });

    log("getHostAccountStatement body > $body");

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
    print("filter wallet");
    print(body);
    final response = await send(request);
    return PageResponse<WalletStatementListingResponse>.fromJson(response.data);
  }

  Future<PageResponse<WalletStatementListingResponse>>
      walletStatementHistoryListing(
          {required final String date,
          final int? pageNo,
          required final int transactionType,
          required final int hostId,
          required bool fromWallet,
          WalletFiltersModel? walletFiltersModel}) async {
    // Building query
    final uri = getUri('/m/api/getListOfDebitOrCreditAccountStatement');
    // Request body
    final body = jsonEncode({
      if (!fromWallet) "date": date,
      if (!fromWallet) "host_id": hostId,
      "transaction_type": transactionType,
      if (!fromWallet) 'items_per_page': 50,
      if (!fromWallet) 'page_no': pageNo,
      if (!fromWallet) 'hg3': walletFiltersModel?.transactionType,
      if (!fromWallet) 'fromdate': walletFiltersModel?.fromDate,
      if (!fromWallet) 'todate': walletFiltersModel?.toDate,
    });
    print("getListOfDebitOrCreditAccountStatement > $body");
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

    print("getListOfDebitOrCreditAccountStatement response > ${response.data}");
    return PageResponse<WalletStatementListingResponse>.fromJson(response.data);
  }

  Future<BarGraphResp> barGraphApi() async {
    // Building query
    final uri = getUri('/m/api/getHostPaymentGraph');
    // Request body
    final body = {};
    print("getHostPaymentGraph > $body");
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
    return BarGraphResp.fromJson(response.data);
  }
}
