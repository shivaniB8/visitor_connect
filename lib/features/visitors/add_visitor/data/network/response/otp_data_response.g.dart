// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'otp_data_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OtpDataResponse _$OtpDataResponseFromJson(Map<String, dynamic> json) =>
    OtpDataResponse(
      id: json['aa1'] as int?,
      lastDigits: json['last_digits'] as String?,
      isAadharExist: json['is_exits'] as int?,
      aadharDataResponse: json['aadhardata'] == null
          ? null
          : AadharDataResponse.fromJson(
              json['aadhardata'] as Map<String, dynamic>),
      mobileNumber: json['aa13'] as String?,
      aadharNumber: json['ag3'] as String?,
    );

Map<String, dynamic> _$OtpDataResponseToJson(OtpDataResponse instance) =>
    <String, dynamic>{
      'aa1': instance.id,
      'last_digits': instance.lastDigits,
      'aadhardata': instance.aadharDataResponse?.toJson(),
      'is_exits': instance.isAadharExist,
      'aa13': instance.mobileNumber,
      'ag3': instance.aadharNumber,
    };
