import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'client_info_response.g.dart';

@JsonSerializable(explicitToJson: true)
class ClientInfoResponse extends Equatable {
  @JsonKey(name: 'maa1')
  final int? clientId;

  @JsonKey(name: 'maa2')
  final String? clientName;

  @JsonKey(name: 'maa6')
  final String? logo;

  @JsonKey(name: 'maa24')
  final String? bucketName;

  const ClientInfoResponse({
    this.clientId,
    this.clientName,
    this.logo,
    this.bucketName,
  });

  factory ClientInfoResponse.fromJson(Map<String, dynamic> json) =>
      _$ClientInfoResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ClientInfoResponseToJson(this);

  @override
  List<Object?> get props => [
        clientId,
        clientName,
        logo,
        bucketName,
      ];
}
