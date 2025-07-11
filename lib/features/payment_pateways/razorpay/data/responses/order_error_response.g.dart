// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_error_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderErrorResponse _$OrderErrorResponseFromJson(Map<String, dynamic> json) =>
    OrderErrorResponse(
      code: json['code'] as String?,
      description: json['description'] as String?,
      reason: json['reason'] as String?,
      source: json['source'] as String?,
      step: json['step'] as String?,
    );

Map<String, dynamic> _$OrderErrorResponseToJson(OrderErrorResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'description': instance.description,
      'reason': instance.reason,
      'source': instance.source,
      'step': instance.step,
    };
