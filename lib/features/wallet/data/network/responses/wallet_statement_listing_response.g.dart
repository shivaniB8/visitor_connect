// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_statement_listing_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WalletStatementListingResponse _$WalletStatementListingResponseFromJson(
        Map<String, dynamic> json) =>
    WalletStatementListingResponse(
      id: json['id'],
      clientId: json['client_id'] as int?,
      transactionType: json['transaction_type'] as int?,
      creditThrough: json['credit_through'] as int?,
      creditAmount: (json['credit_amount'] as num?)?.toDouble(),
      creditStatus: json['credit_status'] as int?,
      hostId: json['host_id'] as int?,
      creditDate: json['credit_date'] as String?,
      creditTime: json['credit_time'] as String?,
      debitAmount: (json['debit_amount'] as num?)?.toDouble(),
      componentName: json['component_name'] as String?,
      balanceAmount: json['balance_amount'] as int?,
      debitDate: json['debit_date'] as String?,
      debitTime: json['debit_time'] as String?,
      debitComponentCount: json['debit_component_count'],
      debitComponentCharge: json['debit_component_charge'] as String?,
      debitFor: json['debit_for'] as int?,
      heading: json['particulars'] as String?,
      visitorId: json['visitor_id'] as int?,
      roomNo: json['room_no'] as String?,
      visitorName: json['visitor_name'] as String?,
    );

Map<String, dynamic> _$WalletStatementListingResponseToJson(
        WalletStatementListingResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'client_id': instance.clientId,
      'host_id': instance.hostId,
      'transaction_type': instance.transactionType,
      'credit_through': instance.creditThrough,
      'credit_amount': instance.creditAmount,
      'credit_status': instance.creditStatus,
      'credit_date': instance.creditDate,
      'credit_time': instance.creditTime,
      'debit_amount': instance.debitAmount,
      'component_name': instance.componentName,
      'balance_amount': instance.balanceAmount,
      'debit_date': instance.debitDate,
      'debit_time': instance.debitTime,
      'debit_component_count': instance.debitComponentCount,
      'debit_component_charge': instance.debitComponentCharge,
      'debit_for': instance.debitFor,
      'particulars': instance.heading,
      'visitor_id': instance.visitorId,
      'visitor_name': instance.visitorName,
      'room_no': instance.roomNo,
    };
