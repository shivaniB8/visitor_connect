import 'package:host_visitor_connect/common/data/network/responses/key_value_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'module_response.g.dart';

@JsonSerializable()
class ModuleResponse {
  @JsonKey(name: 'success')
  final bool? success;

  @JsonKey(name: 'status')
  final int? status;

  @JsonKey(name: 'message')
  final String? message;

  @JsonKey(name: 'mbk4')
  final String? voterFk;

  @JsonKey(name: 'parentModules')
  final List<KeyValueResponse>? data;

  ModuleResponse({
    this.success,
    this.status,
    this.message,
    this.data,
    this.voterFk,
  });

  factory ModuleResponse.fromJson(Map<String, dynamic> json) =>
      _$ModuleResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ModuleResponseToJson(this);
}
