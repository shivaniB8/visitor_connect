import 'package:equatable/equatable.dart';
import 'package:host_visitor_connect/features/visitors/add_visitor/data/network/response/otp_data_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'otp_generation_response.g.dart';

@JsonSerializable(explicitToJson: true)
class OtpGenerationResponse extends Equatable {
  @JsonKey(name: 'success')
  final bool? success;

  @JsonKey(name: 'status')
  final int? status;

  @JsonKey(name: 'message')
  final String? message;

  @JsonKey(name: 'msg')
  final String? msg;

  @JsonKey(name: 'data')
  final OtpDataResponse? data;

  @JsonKey(name: 'is_otp')
  final int? isOtp;

  @JsonKey(name: 'timer')
  final int? timer;

  const OtpGenerationResponse({
    this.success,
    this.status,
    this.message,
    this.msg,
    this.data,
    this.isOtp,
    this.timer,
  });

  factory OtpGenerationResponse.fromJson(Map<String, dynamic> json) =>
      _$OtpGenerationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OtpGenerationResponseToJson(this);

  @override
  List<Object?> get props => [
        success,
        status,
        message,
        msg,
        data,
        isOtp,
        timer,
      ];
}
