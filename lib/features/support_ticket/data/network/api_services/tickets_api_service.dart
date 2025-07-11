import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:host_visitor_connect/common/data/network/api_services/base_api_service.dart';
import 'package:host_visitor_connect/common/data/network/responses/key_value_list_response.dart';
import 'package:host_visitor_connect/common/data/network/responses/page_response.dart';
import 'package:host_visitor_connect/common/data/network/responses/success_response.dart';
import 'package:host_visitor_connect/common/extensions/string_extensions.dart';
import 'package:host_visitor_connect/common/res/keys.dart';
import 'package:host_visitor_connect/common/shared_prefs.dart';
import 'package:host_visitor_connect/features/support_ticket/data/network/responses/module_response.dart';
import 'package:host_visitor_connect/features/support_ticket/data/network/responses/ticket_history_response.dart';
import 'package:host_visitor_connect/features/support_ticket/data/network/responses/ticket_response.dart';
import 'package:image_picker/image_picker.dart';

class TicketApiService extends BaseApiService {
  TicketApiService({httpClient}) : super(httpClient);

  Future<PageResponse<TicketResponse>> getTickets({
    int? pageNo,
    required int status,
    int? sa5,
    String? submittedFrom,
    String? submittedTill,
    String? tentativeDateFrom,
    String? tentativeDateTill,
    String? closedDateFrom,
    String? closedDateTill,
    String? cancelledDateFrom,
    String? cancelledDateTill,
    int? ticketNumber,
  }) async {
    // Building query
    final uri = getUri('/m/api/getTicketsByStatus');

    final requestOptions = getOptions(
      headers: {
        HttpHeaders.authorizationHeader: "Bearer ${getAuthToken()}",
        "mobile-type":
            defaultTargetPlatform == TargetPlatform.android ? "1" : "2",
        "user": SharedPrefs.getString(keyUserData),
        "client": SharedPrefs.getInt(keyClientId),
        "user-login-branch": SharedPrefs.getInt(keyBranch) ?? 0,
      },
    );

    // Request body
    final body = jsonEncode({
      "status": status,
      'page_no': pageNo,
      "sa5": sa5,
      "sa4": ticketNumber,
      "sub_date_from": submittedFrom?.split(' ')[0],
      "sub_date_to": submittedTill?.split(' ')[0],
      "tentative_date_from": tentativeDateFrom?.split(' ')[0],
      "Tentative_date_to": tentativeDateTill?.split(' ')[0],
      "close_date_from": closedDateFrom?.split(' ')[0],
      "close_date_to": closedDateTill?.split(' ')[0],
      "cancel_date_from": cancelledDateFrom?.split(' ')[0],
      "cancel_date_to": cancelledDateTill?.split(' ')[0],
    });

    // Building request
    final request = httpClient.post(
      uri.toString(),
      options: requestOptions,
      data: body,
    );

    print(body);

    // Sending request
    final response = await send(request);
    return PageResponse<TicketResponse>.fromJson(response.data);
  }

  Future<TicketHistoryResponse> ticketHistory({
    required int sa1,
  }) async {
    // Building query
    final uri = getUri('/m/api/getTicketMessages');

    final requestOptions = getOptions(
      headers: {
        HttpHeaders.authorizationHeader: "Bearer ${getAuthToken()}",
        "mobile-type":
            defaultTargetPlatform == TargetPlatform.android ? "1" : "2",
        "user": SharedPrefs.getString(keyUserData),
        "client": SharedPrefs.getInt(keyClientId),
        "user-login-branch": SharedPrefs.getInt(keyBranch) ?? 0,
      },
    );

    // Request body
    final body = jsonEncode({"sa1": sa1});

    // Building request
    final request = httpClient.post(
      uri.toString(),
      options: requestOptions,
      data: body,
    );

    // Sending request
    final response = await send(request);
    return TicketHistoryResponse.fromJson(response.data);
  }

  Future<KeyValueListResponse> getUsersList({
    int? isMobile,
  }) async {
    // Building query
    final uri = getUri('/m/api/getActiveUsers');

    final requestOptions = getOptions(
      headers: {
        HttpHeaders.authorizationHeader: "Bearer ${getAuthToken()}",
        "mobile-type":
            defaultTargetPlatform == TargetPlatform.android ? "1" : "2",
        "user": SharedPrefs.getString(keyUserData),
        "client": SharedPrefs.getInt(keyClientId),
        "user-login-branch": SharedPrefs.getInt(keyBranch) ?? 0,
      },
    );

    // Request body
    final body = jsonEncode({"isMobile": isMobile});

    // Building request
    final request = httpClient.post(
      uri.toString(),
      options: requestOptions,
      data: body,
    );

    // Sending request
    final response = await send(request);
    return KeyValueListResponse.fromJson(response.data);
  }

  Future<ModuleResponse> getModules() async {
    // Building query
    final uri = getUri('/m/api/common/getModules');

    final requestOptions = getOptions(
      headers: {
        HttpHeaders.authorizationHeader: "Bearer ${getAuthToken()}",
        "mobile-type":
            defaultTargetPlatform == TargetPlatform.android ? "1" : "2",
        "user": SharedPrefs.getString(keyUserData),
        "client": SharedPrefs.getInt(keyClientId),
        "user-login-branch":
        SharedPrefs.getInt(keyBranch) ?? 0,
      },
    );

    // Request body

    // Building request
    final request = httpClient.post(
      uri.toString(),
      options: requestOptions,
    );

    // Sending request
    final response = await send(request);
    return ModuleResponse.fromJson(response.data);
  }

  Future<SuccessResponse> createTicket({
    required Map<String, dynamic> createTicketMap,
    XFile? screenshot1,
    XFile? screenshot2,
    XFile? screenshot3,
    XFile? screenshot4,
    XFile? screenshot5,
  }) async {
    // Building query
    final uri = getUri('m/api/createTicket');

    final requestOptions = getOptions(
      headers: {
        HttpHeaders.authorizationHeader: "Bearer ${getAuthToken()}",
        "mobile-type":
            defaultTargetPlatform == TargetPlatform.android ? "1" : "2",
        "user": SharedPrefs.getString(keyUserData),
        "client": SharedPrefs.getInt(keyClientId),
        "user-login-branch":
        SharedPrefs.getInt(keyBranch) ?? 0,
      },
    );

    // Request body
    var body = FormData.fromMap(createTicketMap, ListFormat.multiCompatible);
    if (!(screenshot1?.path.isNullOrEmpty() ?? true)) {
      body.files.add(
        MapEntry(
          'screenfile1',
          MultipartFile.fromFileSync(
            screenshot1!.path,
          ),
        ),
      );
    }
    if (!(screenshot2?.path.isNullOrEmpty() ?? true)) {
      body.files.add(
        MapEntry(
          'screenfile2',
          MultipartFile.fromFileSync(
            screenshot2!.path,
          ),
        ),
      );
    }
    if (!(screenshot3?.path.isNullOrEmpty() ?? true)) {
      body.files.add(
        MapEntry(
          'screenfile3',
          MultipartFile.fromFileSync(
            screenshot3!.path,
          ),
        ),
      );
    }
    if (!(screenshot4?.path.isNullOrEmpty() ?? true)) {
      body.files.add(
        MapEntry(
          'screenfile4',
          MultipartFile.fromFileSync(
            screenshot4!.path,
          ),
        ),
      );
    }
    if (!(screenshot5?.path.isNullOrEmpty() ?? true)) {
      body.files.add(
        MapEntry(
          'screenfile5',
          MultipartFile.fromFileSync(
            screenshot5!.path,
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
    return SuccessResponse.fromJson(response.data);
  }

  Future<SuccessResponse> cancelTicket({
    String? sb5,
    required int sa1,
  }) async {
    // Building query
    final uri = getUri('m/api/cancelTicket');

    final requestOptions = getOptions(
      headers: {
        HttpHeaders.authorizationHeader: "Bearer ${getAuthToken()}",
        "mobile-type":
            defaultTargetPlatform == TargetPlatform.android ? "1" : "2",
        "user": SharedPrefs.getString(keyUserData),
        "client": SharedPrefs.getInt(keyClientId),
        "user-login-branch":
        SharedPrefs.getInt(keyBranch) ?? 0,
      },
    );

    // Building request
    final request = httpClient.post(
      uri.toString(),
      options: requestOptions,
      data: {
        "sa1": sa1,
        "sb5": sb5,
        "sa18": 5,
      },
    );

    // Sending request
    final response = await send(request);
    return SuccessResponse.fromJson(response.data);
  }

  Future<SuccessResponse> ticketCommunication({
    String? sb5,
    required int sa1,
    XFile? screenshot1,
    XFile? screenshot2,
    XFile? screenshot3,
    XFile? screenshot4,
    XFile? screenshot5,
  }) async {
    // Building query
    final uri = getUri('m/api/ticketCommunication');

    var body = FormData.fromMap({
      "sa1": sa1,
      "sb5": sb5,
    });
    if (!(screenshot1?.path.isNullOrEmpty() ?? true)) {
      body.files.add(
        MapEntry(
          'screenfileedit1',
          MultipartFile.fromFileSync(
            screenshot1!.path,
          ),
        ),
      );
    }
    if (!(screenshot2?.path.isNullOrEmpty() ?? true)) {
      body.files.add(
        MapEntry(
          'screenfileedit2',
          MultipartFile.fromFileSync(
            screenshot2!.path,
          ),
        ),
      );
    }
    if (!(screenshot3?.path.isNullOrEmpty() ?? true)) {
      body.files.add(
        MapEntry(
          'screenfileedit3',
          MultipartFile.fromFileSync(
            screenshot3!.path,
          ),
        ),
      );
    }
    if (!(screenshot4?.path.isNullOrEmpty() ?? true)) {
      body.files.add(
        MapEntry(
          'screenfileedit4',
          MultipartFile.fromFileSync(
            screenshot4!.path,
          ),
        ),
      );
    }
    if (!(screenshot5?.path.isNullOrEmpty() ?? true)) {
      body.files.add(
        MapEntry(
          'screenfileedit5',
          MultipartFile.fromFileSync(
            screenshot5!.path,
          ),
        ),
      );
    }

    final requestOptions = getOptions(
      headers: {
        HttpHeaders.authorizationHeader: "Bearer ${getAuthToken()}",
        "mobile-type":
            defaultTargetPlatform == TargetPlatform.android ? "1" : "2",
        "user": SharedPrefs.getString(keyUserData),
        "client": SharedPrefs.getInt(keyClientId),
        "user-login-branch":
        SharedPrefs.getInt(keyBranch) ?? 0,
      },
    );

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
}
