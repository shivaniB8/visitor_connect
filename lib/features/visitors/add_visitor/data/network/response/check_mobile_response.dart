import 'package:equatable/equatable.dart';
import 'package:host_visitor_connect/features/visitors/add_visitor/data/network/response/mobile_response_data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'check_mobile_response.g.dart';

@JsonSerializable(explicitToJson: true)
class CheckMobileResponse extends Equatable {
  @JsonKey(name: 'success')
  final bool? success;

  @JsonKey(name: 'message')
  final String? message;

  @JsonKey(name: 'status')
  final int? status;

  @JsonKey(name: 'data')
  final MobileResponseData? mobileResponseData;

  const CheckMobileResponse({
    this.message,
    this.success,
    this.status,
    this.mobileResponseData,
  });

  factory CheckMobileResponse.fromJson(Map<String, dynamic> json) =>
      _$CheckMobileResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CheckMobileResponseToJson(this);

  @override
  List<Object?> get props => [
        message,
        success,
        status,
        mobileResponseData,
      ];
}
