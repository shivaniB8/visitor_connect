import 'package:json_annotation/json_annotation.dart';

part 'api_error_response.g.dart';

List<dynamic> _getErrorFromJson(Map json, String key) {
  if (json[key] != null && json[key].runtimeType == String) {
    return [json[key]];
  }
  return json[key] ?? [json['error']];
}

@JsonSerializable()
class ApiErrorResponse {
  @JsonKey(name: 'errors', readValue: _getErrorFromJson)
  final String? errors;

  ApiErrorResponse({
    this.errors,
  });

  factory ApiErrorResponse.fromJson(Map<String, dynamic> json) =>
      _$ApiErrorResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ApiErrorResponseToJson(this);
}
