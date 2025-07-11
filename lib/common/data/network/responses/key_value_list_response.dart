import 'package:host_visitor_connect/common/data/network/responses/key_value_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'key_value_list_response.g.dart';

@JsonSerializable()
class KeyValueListResponse {
  @JsonKey(name: 'success')
  final bool? success;

  @JsonKey(name: 'status')
  final int? status;

  @JsonKey(name: 'message')
  final String? message;

  @JsonKey(name: 'mbk4')
  final String? voterFk;

  @JsonKey(name: 'data')
  final List<KeyValueResponse>? data;

  KeyValueListResponse({
    this.success,
    this.status,
    this.message,
    this.data,
    this.voterFk,
  });

  factory KeyValueListResponse.fromJson(Map<String, dynamic> json) =>
      _$KeyValueListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$KeyValueListResponseToJson(this);
}
