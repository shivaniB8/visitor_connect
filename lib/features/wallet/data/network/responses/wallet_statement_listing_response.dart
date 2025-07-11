import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'wallet_statement_listing_response.g.dart';

@JsonSerializable(explicitToJson: true)
class WalletStatementListingResponse extends Equatable {
  @JsonKey(name: 'id')
  final dynamic id;

  @JsonKey(name: 'client_id')
  final int? clientId;

  @JsonKey(name: 'host_id')
  final int? hostId;

  @JsonKey(name: 'transaction_type')
  final int? transactionType;

  @JsonKey(name: 'credit_through')
  final int? creditThrough;

  @JsonKey(name: 'credit_amount')
  final double? creditAmount;

  @JsonKey(name: 'credit_status')
  final int? creditStatus;

  @JsonKey(name: 'credit_date')
  final String? creditDate;

  @JsonKey(name: 'credit_time')
  final String? creditTime;

  @JsonKey(name: 'debit_amount')
  final double? debitAmount;

  @JsonKey(name: 'component_name')
  final String? componentName;

  @JsonKey(name: 'balance_amount')
  final int? balanceAmount;

  @JsonKey(name: 'debit_date')
  final String? debitDate;

  @JsonKey(name: 'debit_time')
  final String? debitTime;

  @JsonKey(name: 'debit_component_count')
  final dynamic debitComponentCount;

  @JsonKey(name: 'debit_component_charge')
  final String? debitComponentCharge;

  @JsonKey(name: 'debit_for')
  final int? debitFor;

  @JsonKey(name: 'particulars')
  final String? heading;

  @JsonKey(name: 'visitor_id')
  final int? visitorId;

  @JsonKey(name: 'visitor_name')
  final String? visitorName;

  @JsonKey(name: 'room_no')
  final String? roomNo;

  const WalletStatementListingResponse(
      {this.id,
      this.clientId,
      this.transactionType,
      this.creditThrough,
      this.creditAmount,
      this.creditStatus,
      this.hostId,
      this.creditDate,
      this.creditTime,
      this.debitAmount,
      this.componentName,
      this.balanceAmount,
      this.debitDate,
      this.debitTime,
      this.debitComponentCount,
      this.debitComponentCharge,
      this.debitFor,
      this.heading,
      this.visitorId,
      this.roomNo,
      this.visitorName});

  factory WalletStatementListingResponse.fromJson(Map<String, dynamic> json) =>
      _$WalletStatementListingResponseFromJson(json);

  Map<String, dynamic> toJson() => _$WalletStatementListingResponseToJson(this);

  @override
  List<Object?> get props => [
        id,
        clientId,
        transactionType,
        creditThrough,
        hostId,
        creditAmount,
        creditStatus,
        creditDate,
        creditTime,
        debitAmount,
        componentName,
        balanceAmount,
        debitDate,
        debitTime,
        debitComponentCount,
        debitComponentCharge,
        debitFor,
        heading,
        visitorId,
        visitorName,
        roomNo
      ];
}
