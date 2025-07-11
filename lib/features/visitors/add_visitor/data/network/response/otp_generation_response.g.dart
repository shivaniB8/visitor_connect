// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'otp_generation_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OtpGenerationResponse _$OtpGenerationResponseFromJson(
        Map<String, dynamic> json) =>
    OtpGenerationResponse(
      success: json['success'] as bool?,
      status: json['status'] as int?,
      message: json['message'] as String?,
      msg: json['msg'] as String?,
      data: json['data'] == null
          ? null
          : OtpDataResponse.fromJson(json['data'] as Map<String, dynamic>),
      isOtp: json['is_otp'] as int?,
      timer: json['timer'] as int?,
    );

Map<String, dynamic> _$OtpGenerationResponseToJson(
        OtpGenerationResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'status': instance.status,
      'message': instance.message,
      'msg': instance.msg,
      'data': instance.data?.toJson(),
      'is_otp': instance.isOtp,
      'timer': instance.timer,
    };
