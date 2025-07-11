// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_mobile_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckMobileResponse _$CheckMobileResponseFromJson(Map<String, dynamic> json) =>
    CheckMobileResponse(
      message: json['message'] as String?,
      success: json['success'] as bool?,
      status: json['status'] as int?,
      mobileResponseData: json['data'] == null
          ? null
          : MobileResponseData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CheckMobileResponseToJson(
        CheckMobileResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'status': instance.status,
      'data': instance.mobileResponseData?.toJson(),
    };
