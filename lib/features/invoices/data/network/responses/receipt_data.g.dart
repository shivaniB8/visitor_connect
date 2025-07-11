// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'receipt_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReceiptData _$ReceiptDataFromJson(Map<String, dynamic> json) => ReceiptData(
      json['hc16'] as String?,
      id: json['hc1'] as String?,
      clientFk: json['hc2'] as int?,
      clientFkValue: json['hc3'] as String?,
      paymentDate: json['hc6'] as String?,
      paymentDetails: json['hc10'] as String?,
      paymentId: json['hc8'] as String?,
      paymentInWords: json['hc21'] as int?,
      paymentMode: json['hc7'] as int?,
      paymentOrderId: json['hc18'] as String?,
      paymentReceiptName: json['hc15'] as String?,
      razorPayCheckoutFK: json['hc4'] as int?,
      receiptDate: json['hc5'] as String?,
      signature: json['hc9'] as String?,
    );

Map<String, dynamic> _$ReceiptDataToJson(ReceiptData instance) =>
    <String, dynamic>{
      'hc1': instance.id,
      'hc2': instance.clientFk,
      'hc3': instance.clientFkValue,
      'hc4': instance.razorPayCheckoutFK,
      'hc5': instance.receiptDate,
      'hc6': instance.paymentDate,
      'hc7': instance.paymentMode,
      'hc8': instance.paymentId,
      'hc9': instance.signature,
      'hc10': instance.paymentDetails,
      'hc15': instance.paymentReceiptName,
      'hc16': instance.paymentReceiptUrl,
      'hc18': instance.paymentOrderId,
      'hc21': instance.paymentInWords,
    };
