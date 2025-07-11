// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'qr_scanner_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QrScannerResponse _$QrScannerResponseFromJson(Map<String, dynamic> json) =>
    QrScannerResponse(
      success: json['success'] as bool?,
      status: json['status'] as int?,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : QrScannerDataResponse.fromJson(
              json['data'] as Map<String, dynamic>),
      drivingLicenseData: json['licence_data'] == null
          ? null
          : DrivingLicenseData.fromJson(
              json['licence_data'] as Map<String, dynamic>),
      sendDrivingLicenseStatus: json['sendDrivingLincenceStatus'] as int?,
    );

Map<String, dynamic> _$QrScannerResponseToJson(QrScannerResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'status': instance.status,
      'message': instance.message,
      'sendDrivingLincenceStatus': instance.sendDrivingLicenseStatus,
      'data': instance.data?.toJson(),
      'licence_data': instance.drivingLicenseData?.toJson(),
    };
