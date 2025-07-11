import 'package:equatable/equatable.dart';
import 'package:host_visitor_connect/features/login/data/network/response/login_user_data_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_response.g.dart';

@JsonSerializable(explicitToJson: true)
class LoginResponse extends Equatable {
  @JsonKey(name: 'data')
  final LoginUserDataResponse? data;

  @JsonKey(name: 'success')
  final bool? success;

  @JsonKey(name: 'message')
  final String? message;

  @JsonKey(name: 'status')
  final int? status;

  @JsonKey(name: 'logout_reason')
  final int? logoutReason;

  @JsonKey(name: 'aq1')
  final int? reLoginId;

  const LoginResponse({
    this.data,
    this.message,
    this.success,
    this.status,
    this.logoutReason,
    this.reLoginId,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);

  @override
  List<Object?> get props =>
      [data, message, success, status, logoutReason, reLoginId];
}
