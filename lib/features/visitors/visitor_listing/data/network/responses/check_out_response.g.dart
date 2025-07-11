// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_out_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckOutResponse _$CheckOutResponseFromJson(Map<String, dynamic> json) =>
    CheckOutResponse(
      success: json['success'] as bool?,
      status: json['status'] as int?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$CheckOutResponseToJson(CheckOutResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'status': instance.status,
      'message': instance.message,
    };
