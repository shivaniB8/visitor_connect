import 'package:equatable/equatable.dart';
import 'package:host_visitor_connect/features/visitors/history/data/network/responses/visitor_history_response.dart';

class History extends Equatable {
  final int? id;
  final int? visitorFk;
  final String? visitorFkValue;
  final int? hostFk;
  final String? entryDateTime;
  final String? exitDateTime;
  final int? branchFk;
  final String? branchValue;
  final String? updatedAt;
  final String? updatedBy;
  final String? hostFkValue;
  final int? reasonFkValue;
  final String? reasonValue;
  final String? briefReason;

  const History(
      {this.id,
      this.visitorFk,
      this.visitorFkValue,
      this.hostFk,
      this.entryDateTime,
      this.exitDateTime,
      this.branchFk,
      this.branchValue,
      this.updatedAt,
      this.updatedBy,
      this.hostFkValue,
      this.reasonValue,
      this.reasonFkValue,
      this.briefReason});

  factory History.fromApiResponse(
    VisitorHistoryResponse visitorHistoryResponse,
  ) {
    return History(
      id: visitorHistoryResponse.id,
      visitorFkValue: visitorHistoryResponse.visitorFkValue,
      visitorFk: visitorHistoryResponse.visitorFk,
      hostFk: visitorHistoryResponse.hostFk,
      entryDateTime: visitorHistoryResponse.entryDateTime,
      exitDateTime: visitorHistoryResponse.exitDateTime,
      branchFk: visitorHistoryResponse.branchFk,
      branchValue: visitorHistoryResponse.branchValue,
      updatedBy: visitorHistoryResponse.updatedBy,
      updatedAt: visitorHistoryResponse.updatedAt,
      hostFkValue: visitorHistoryResponse.hostFkValue,
      reasonValue: visitorHistoryResponse.reasonValue,
      reasonFkValue: visitorHistoryResponse.reasonFkValue,
      briefReason: visitorHistoryResponse.briefReason,
    );
  }

  @override
  List<Object?> get props => [
        id,
        visitorFk,
        visitorFkValue,
        hostFk,
        entryDateTime,
        exitDateTime,
        branchFk,
        branchValue,
        updatedAt,
        updatedBy,
        hostFkValue,
        reasonValue,
        reasonFkValue,
        briefReason
      ];
}
