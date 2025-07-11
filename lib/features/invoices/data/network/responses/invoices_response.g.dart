// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoices_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InvoicesResponse _$InvoicesResponseFromJson(Map<String, dynamic> json) =>
    InvoicesResponse(
      data: json['data'] == null
          ? null
          : InvoicesListResponse.fromJson(json['data'] as Map<String, dynamic>),
      message: json['message'] as String?,
      success: json['success'] as bool?,
      status: json['status'] as int?,
    );

Map<String, dynamic> _$InvoicesResponseToJson(InvoicesResponse instance) =>
    <String, dynamic>{
      'data': instance.data?.toJson(),
      'success': instance.success,
      'message': instance.message,
      'status': instance.status,
    };
