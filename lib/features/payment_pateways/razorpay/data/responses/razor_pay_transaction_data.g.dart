// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'razor_pay_transaction_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RazorPayTransactionData _$RazorPayTransactionDataFromJson(
        Map<String, dynamic> json) =>
    RazorPayTransactionData(
      id: json['he1'] as int?,
      clientId: json['he2'] as int?,
      client: json['he3'] as String?,
      amountPaid: json['he7'] as int?,
      paymentMode: json['he8'] as String?,
      transactionId: json['he9'] as String?,
      orderId: json['he10'] as String?,
      paymentSubMode: json['he12'] as String?,
    );

Map<String, dynamic> _$RazorPayTransactionDataToJson(
        RazorPayTransactionData instance) =>
    <String, dynamic>{
      'he1': instance.id,
      'he2': instance.clientId,
      'he3': instance.client,
      'he7': instance.amountPaid,
      'he8': instance.paymentMode,
      'he9': instance.transactionId,
      'he10': instance.orderId,
      'he12': instance.paymentSubMode,
    };
