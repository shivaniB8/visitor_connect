// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'razor_pay_transaction_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RazorPayTransactionResponse _$RazorPayTransactionResponseFromJson(
        Map<String, dynamic> json) =>
    RazorPayTransactionResponse(
      message: json['message'] as String?,
      records: json['response'] == null
          ? null
          : RazorPayOrderResponse.fromJson(
              json['response'] as Map<String, dynamic>),
      status: json['status'] as int?,
    );

Map<String, dynamic> _$RazorPayTransactionResponseToJson(
        RazorPayTransactionResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'response': instance.records?.toJson(),
    };
