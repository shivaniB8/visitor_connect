import 'package:equatable/equatable.dart';
import 'package:host_visitor_connect/common/data/network/responses/key_value_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_data_response.g.dart';

@JsonSerializable(explicitToJson: true)
class LoginDataResponse extends Equatable {
  @JsonKey(name: 'host_branches_list')
  final List<KeyValueResponse>? branches;

  @JsonKey(name: 'ad1')
  final int? ad1;

  @JsonKey(name: 'ad2')
  final int? ad2;

  @JsonKey(name: 'ad3')
  final String? ad3;

  @JsonKey(name: 'ad9')
  final String? ad9;

  @JsonKey(name: 'ad22')
  final String? ad22;

  const LoginDataResponse({
    this.branches,
    this.ad1,
    this.ad2,
    this.ad3,
    this.ad9,
    this.ad22,
  });

  factory LoginDataResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginDataResponseToJson(this);

  @override
  List<Object?> get props => [
        branches,
        ad1,
        ad2,
        ad3,
        ad9,
        ad22,
      ];
}
