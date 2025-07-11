import 'package:equatable/equatable.dart';
import 'package:host_visitor_connect/features/visitors/add_visitor/data/network/response/aadhar_data_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'otp_data_response.g.dart';

@JsonSerializable(explicitToJson: true)
class OtpDataResponse extends Equatable {
  @JsonKey(name: 'aa1')
  final int? id;

  @JsonKey(name: 'last_digits')
  final String? lastDigits;

  @JsonKey(name: 'aadhardata')
  final AadharDataResponse? aadharDataResponse;

  @JsonKey(name: 'is_exits')
  final int? isAadharExist;

  @JsonKey(name: 'aa13')
  final String? mobileNumber;

  @JsonKey(name: 'ag3')
  final String? aadharNumber;

  const OtpDataResponse({
    this.id,
    this.lastDigits,
    this.isAadharExist,
    this.aadharDataResponse,
    this.mobileNumber,
    this.aadharNumber,
  });

  factory OtpDataResponse.fromJson(Map<String, dynamic> json) =>
      _$OtpDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OtpDataResponseToJson(this);

  @override
  List<Object?> get props => [
        id,
        lastDigits,
        isAadharExist,
        aadharDataResponse,
        mobileNumber,
        aadharNumber,
      ];
}
