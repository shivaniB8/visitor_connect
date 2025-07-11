import 'package:host_visitor_connect/features/qr/data/network/responses/qr_scanner_data_response.dart';
import 'package:host_visitor_connect/features/rentals/data/network/responses/driving_licence_data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'qr_scanner_response.g.dart';

@JsonSerializable(explicitToJson: true)
class QrScannerResponse {
  @JsonKey(name: 'success')
  final bool? success;

  @JsonKey(name: 'status')
  final int? status;

  @JsonKey(name: 'message')
  final String? message;

  @JsonKey(name: 'sendDrivingLincenceStatus')
  final int? sendDrivingLicenseStatus;

  @JsonKey(name: 'data')
  final QrScannerDataResponse? data;

  @JsonKey(name: 'licence_data')
  final DrivingLicenseData? drivingLicenseData;

  QrScannerResponse({
    this.success,
    this.status,
    this.message,
    this.data,
    this.drivingLicenseData,
    this.sendDrivingLicenseStatus,
  });

  factory QrScannerResponse.fromJson(Map<String, dynamic> json) =>
      _$QrScannerResponseFromJson(json);

  Map<String, dynamic> toJson() => _$QrScannerResponseToJson(this);
}
