import 'package:equatable/equatable.dart';
import 'package:host_visitor_connect/features/login/data/network/response/login_data_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_branch_response.g.dart';

@JsonSerializable(explicitToJson: true)
class LoginBranchResponse extends Equatable {
  @JsonKey(name: 'data')
  final List<LoginDataResponse>? data;

  @JsonKey(name: 'success')
  final bool? success;

  @JsonKey(name: 'master_bucket_name')
  final String? masterBucketName;

  @JsonKey(name: 'message')
  final String? message;

  @JsonKey(name: 'status')
  final int? status;

  const LoginBranchResponse(this.masterBucketName,
      {this.data, this.status, this.message, this.success});

  factory LoginBranchResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginBranchResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginBranchResponseToJson(this);

  @override
  List<Object?> get props => [
        data,
        success,
        status,
        masterBucketName,
        message,
      ];
}
