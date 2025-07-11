import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'virtual_mobile_response.g.dart';

@JsonSerializable(explicitToJson: true)
class VirtualMobileResponse extends Equatable {
  @JsonKey(name: 'cn2')
  final String? virtualNumber;

  @JsonKey(name: 'mobile_one')
  final String? actualNumber;

  @JsonKey(name: 'cn1')
  final int? settingId;

  const VirtualMobileResponse({
    this.virtualNumber,
    this.actualNumber,
    this.settingId,
  });

  factory VirtualMobileResponse.fromJson(Map<String, dynamic> json) =>
      _$VirtualMobileResponseFromJson(json);

  Map<String, dynamic> toJson() => _$VirtualMobileResponseToJson(this);

  @override
  List<Object?> get props => [
        virtualNumber,
        actualNumber,
        settingId,
      ];
}
