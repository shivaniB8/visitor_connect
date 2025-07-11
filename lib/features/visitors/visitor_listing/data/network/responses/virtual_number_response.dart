import 'package:equatable/equatable.dart';
import 'package:host_visitor_connect/features/visitors/visitor_listing/data/network/responses/virtual_mobile_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'virtual_number_response.g.dart';

@JsonSerializable(explicitToJson: true)
class VirtualNumberResponse extends Equatable {
  @JsonKey(name: 'success')
  final bool? success;

  @JsonKey(name: 'status')
  final int? status;

  @JsonKey(name: 'count')
  final int? count;

  @JsonKey(name: 'record')
  final List<VirtualMobileResponse>? records;

  const VirtualNumberResponse({
    this.success,
    this.status,
    this.count,
    this.records,
  });

  factory VirtualNumberResponse.fromJson(Map<String, dynamic> json) =>
      _$VirtualNumberResponseFromJson(json);

  Map<String, dynamic> toJson() => _$VirtualNumberResponseToJson(this);

  @override
  List<Object?> get props => [
        success,
        status,
        count,
        records,
      ];
}
