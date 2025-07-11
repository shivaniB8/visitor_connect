// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'success_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SuccessResponse<T> _$SuccessResponseFromJson<T>(Map<String, dynamic> json) =>
    SuccessResponse<T>(
      success: json['success'] as bool?,
      confidence: json['confidence'] as int?,
      status: json['status'] as int?,
      message: json['message'] as String?,
      sessionExpired: json['session_expired'] as int?,
    );

Map<String, dynamic> _$SuccessResponseToJson<T>(SuccessResponse<T> instance) =>
    <String, dynamic>{
      'success': instance.success,
      'status': instance.status,
      'message': instance.message,
      'session_expired': instance.sessionExpired,
      'confidence': instance.confidence,
    };
