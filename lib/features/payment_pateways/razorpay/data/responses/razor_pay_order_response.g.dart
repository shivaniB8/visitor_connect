// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'razor_pay_order_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RazorPayOrderResponse _$RazorPayOrderResponseFromJson(
        Map<String, dynamic> json) =>
    RazorPayOrderResponse(
      amount: json['amount'] as int?,
      amountDue: json['amount_due'] as int?,
      amountPaid: json['amount_paid'] as int?,
      attempts: json['attempts'] as int?,
      createdAt: json['created_at'] as int?,
      currency: json['currency'] as String?,
      entity: json['entity'] as String?,
      orderId: json['id'] as String?,
      status: json['status'] as String?,
      error: json['error'] == null
          ? null
          : OrderErrorResponse.fromJson(json['error'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RazorPayOrderResponseToJson(
        RazorPayOrderResponse instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'amount_due': instance.amountDue,
      'amount_paid': instance.amountPaid,
      'attempts': instance.attempts,
      'created_at': instance.createdAt,
      'currency': instance.currency,
      'entity': instance.entity,
      'id': instance.orderId,
      'status': instance.status,
      'error': instance.error?.toJson(),
    };
