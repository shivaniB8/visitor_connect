// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'razor_pay_order_response_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RazorPayOrderResponseData _$RazorPayOrderResponseDataFromJson(
        Map<String, dynamic> json) =>
    RazorPayOrderResponseData(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      records: json['record'] == null
          ? null
          : RazorPayOrderResponse.fromJson(
              json['record'] as Map<String, dynamic>),
      status: json['status'] as int?,
    );

Map<String, dynamic> _$RazorPayOrderResponseDataToJson(
        RazorPayOrderResponseData instance) =>
    <String, dynamic>{
      'success': instance.success,
      'status': instance.status,
      'message': instance.message,
      'record': instance.records?.toJson(),
    };
