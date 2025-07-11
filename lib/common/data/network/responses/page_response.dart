import 'package:host_visitor_connect/features/report/report_list/data/network/responses/report_list_response.dart';
import 'package:host_visitor_connect/features/support_ticket/data/network/responses/ticket_response.dart';
import 'package:host_visitor_connect/features/users/users_listing/data/network/response/users_data_response.dart';
import 'package:host_visitor_connect/features/visitors/history/data/network/responses/visitor_history_response.dart';
import 'package:host_visitor_connect/features/visitors/history/data/network/responses/visitor_room_response.dart';
import 'package:host_visitor_connect/features/visitors/visitor_listing/data/network/responses/visitor_details_response.dart';
import 'package:host_visitor_connect/features/wallet/data/network/responses/wallet_statement_listing_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'page_response.g.dart';

@JsonSerializable(explicitToJson: true)
class PageResponse<T> {
  @JsonKey(name: 'success')
  bool? success;

  @JsonKey(name: 'status')
  int? status;

  @JsonKey(name: 'count')
  int count;

  @JsonKey(name: 'message')
  String? message;

  @JsonKey(name: 'page_no')
  int pageNo;

  @JsonKey(name: 'live_balance')
  int? liveBalance;

  @JsonKey(name: 'session_expired')
  int? sessionExpired;

  @_PageResponseConverter()
  @JsonKey(name: 'data')
  List<T>? content;

  PageResponse({
    this.success,
    this.status,
    this.count = 0,
    this.message,
    this.pageNo = 0,
    this.content,
    this.liveBalance,
    this.sessionExpired,
  });

  factory PageResponse.fromJson(Map<String, dynamic> json) => _$PageResponseFromJson<T>(json);

  Map<String, dynamic> toJson() => _$PageResponseToJson<T>(this);

  bool get isLast => (count / 50) <= pageNo;
}

class _PageResponseConverter<T> implements JsonConverter<T, Object> {
  const _PageResponseConverter();

  @override
  T fromJson(Object json) {
    if (T == VisitorDetailsResponse) {
      return VisitorDetailsResponse.fromJson(json as Map<String, dynamic>) as T;
    }
    if (T == TicketResponse) {
      return TicketResponse.fromJson(json as Map<String, dynamic>) as T;
    }
    if (T == UsersDataResponse) {
      return UsersDataResponse.fromJson(json as Map<String, dynamic>) as T;
    }
    if (T == VisitorRoomResponse) {
      return VisitorRoomResponse.fromJson(json as Map<String, dynamic>) as T;
    }
    if (T == WalletStatementListingResponse) {
      return WalletStatementListingResponse.fromJson(json as Map<String, dynamic>) as T;
    }
    if (T == VisitorHistoryResponse) {
      return VisitorHistoryResponse.fromJson(json as Map<String, dynamic>) as T;
    }
    if (T == ReportListResponse) {
      return ReportListResponse.fromJson(json as Map<String, dynamic>) as T;
    }
    throw UnimplementedError();
  }

  @override
  Object toJson(T object) {
    if (T == VisitorDetailsResponse) {
      return (object as VisitorDetailsResponse).toJson();
    }
    if (T == TicketResponse) {
      return (object as TicketResponse).toJson();
    }
    if (T == WalletStatementListingResponse) {
      return (object as WalletStatementListingResponse).toJson();
    }
    if (T == VisitorHistoryResponse) {
      return (object as VisitorHistoryResponse).toJson();
    }
    if (T == ReportListResponse) {
      return (object as ReportListResponse).toJson();
    }
    throw UnimplementedError();
  }
}
