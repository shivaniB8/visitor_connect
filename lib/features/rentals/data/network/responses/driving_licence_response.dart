import 'package:host_visitor_connect/features/rentals/data/network/responses/driving_licence_data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'driving_licence_response.g.dart';

@JsonSerializable(explicitToJson: true)
class DrivingLicenceResponse {
  @JsonKey(name: 'success')
  final bool? success;

  @JsonKey(name: 'status')
  final int? status;

  @JsonKey(name: 'message')
  final String? message;

  @JsonKey(name: 'data')
  final DrivingLicenseData? data;

  DrivingLicenceResponse({
    this.success,
    this.status,
    this.message,
    this.data,
  });

  factory DrivingLicenceResponse.fromJson(Map<String, dynamic> json) =>
      _$DrivingLicenceResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DrivingLicenceResponseToJson(this);
}
