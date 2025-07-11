// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driving_licence_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DrivingLicenceResponse _$DrivingLicenceResponseFromJson(
        Map<String, dynamic> json) =>
    DrivingLicenceResponse(
      success: json['success'] as bool?,
      status: json['status'] as int?,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : DrivingLicenseData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DrivingLicenceResponseToJson(
        DrivingLicenceResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'status': instance.status,
      'message': instance.message,
      'data': instance.data?.toJson(),
    };
