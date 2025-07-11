import 'package:equatable/equatable.dart';
import 'package:host_visitor_connect/features/login/data/network/response/client_info_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_user_data_response.g.dart';

@JsonSerializable(explicitToJson: true)
class LoginUserDataResponse extends Equatable {
  @JsonKey(name: 'user_reference')
  final String? userReference;

  @JsonKey(name: 'client_info')
  final ClientInfoResponse? clientInfo;

  @JsonKey(name: 'master_bucket_name')
  final String? masterBucket;

  const LoginUserDataResponse({
    this.userReference,
    this.clientInfo,
    this.masterBucket,
  });

  factory LoginUserDataResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginUserDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginUserDataResponseToJson(this);

  @override
  List<Object?> get props => [
        userReference,
        clientInfo,
        masterBucket,
      ];
}
