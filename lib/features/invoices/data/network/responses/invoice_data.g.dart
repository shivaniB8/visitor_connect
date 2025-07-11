// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InvoiceData _$InvoiceDataFromJson(Map<String, dynamic> json) => InvoiceData(
      id: json['hb1'] as String?,
      clientFk: json['hb2'] as int?,
      clientFkValue: json['hb3'] as String?,
      invoiceDate: json['hb6'] as String?,
      amountBeforeTax: (json['hb7'] as num?)?.toDouble(),
      taxAmount: (json['hb8'] as num?)?.toDouble(),
      totalAmount: (json['hb9'] as num?)?.toDouble(),
      fileName: json['hb10'] as String?,
      fileLink: json['hb11'] as String?,
      billMonth: json['hb15'] as int?,
      billYear: json['hb16'] as int?,
      hostFk: json['hb18'] as int?,
    );

Map<String, dynamic> _$InvoiceDataToJson(InvoiceData instance) =>
    <String, dynamic>{
      'hb1': instance.id,
      'hb2': instance.clientFk,
      'hb3': instance.clientFkValue,
      'hb6': instance.invoiceDate,
      'hb7': instance.amountBeforeTax,
      'hb8': instance.taxAmount,
      'hb9': instance.totalAmount,
      'hb10': instance.fileName,
      'hb11': instance.fileLink,
      'hb15': instance.billMonth,
      'hb16': instance.billYear,
      'hb18': instance.hostFk,
    };
