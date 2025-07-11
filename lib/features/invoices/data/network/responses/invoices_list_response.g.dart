// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoices_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InvoicesListResponse _$InvoicesListResponseFromJson(
        Map<String, dynamic> json) =>
    InvoicesListResponse(
      janData: (json['January'] as List<dynamic>?)
          ?.map((e) => InvoiceData.fromJson(e as Map<String, dynamic>))
          .toList(),
      febData: (json['February'] as List<dynamic>?)
          ?.map((e) => InvoiceData.fromJson(e as Map<String, dynamic>))
          .toList(),
      marchData: (json['March'] as List<dynamic>?)
          ?.map((e) => InvoiceData.fromJson(e as Map<String, dynamic>))
          .toList(),
      aprilData: (json['April'] as List<dynamic>?)
          ?.map((e) => InvoiceData.fromJson(e as Map<String, dynamic>))
          .toList(),
      mayData: (json['May'] as List<dynamic>?)
          ?.map((e) => InvoiceData.fromJson(e as Map<String, dynamic>))
          .toList(),
      juneData: (json['June'] as List<dynamic>?)
          ?.map((e) => InvoiceData.fromJson(e as Map<String, dynamic>))
          .toList(),
      julyData: (json['July'] as List<dynamic>?)
          ?.map((e) => InvoiceData.fromJson(e as Map<String, dynamic>))
          .toList(),
      augData: (json['August'] as List<dynamic>?)
          ?.map((e) => InvoiceData.fromJson(e as Map<String, dynamic>))
          .toList(),
      septData: (json['September'] as List<dynamic>?)
          ?.map((e) => InvoiceData.fromJson(e as Map<String, dynamic>))
          .toList(),
      octData: (json['October'] as List<dynamic>?)
          ?.map((e) => InvoiceData.fromJson(e as Map<String, dynamic>))
          .toList(),
      novData: (json['November'] as List<dynamic>?)
          ?.map((e) => InvoiceData.fromJson(e as Map<String, dynamic>))
          .toList(),
      decData: (json['December'] as List<dynamic>?)
          ?.map((e) => InvoiceData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$InvoicesListResponseToJson(
        InvoicesListResponse instance) =>
    <String, dynamic>{
      'January': instance.janData?.map((e) => e.toJson()).toList(),
      'February': instance.febData?.map((e) => e.toJson()).toList(),
      'March': instance.marchData?.map((e) => e.toJson()).toList(),
      'April': instance.aprilData?.map((e) => e.toJson()).toList(),
      'May': instance.mayData?.map((e) => e.toJson()).toList(),
      'June': instance.juneData?.map((e) => e.toJson()).toList(),
      'July': instance.julyData?.map((e) => e.toJson()).toList(),
      'August': instance.augData?.map((e) => e.toJson()).toList(),
      'September': instance.septData?.map((e) => e.toJson()).toList(),
      'October': instance.octData?.map((e) => e.toJson()).toList(),
      'November': instance.novData?.map((e) => e.toJson()).toList(),
      'December': instance.decData?.map((e) => e.toJson()).toList(),
    };
