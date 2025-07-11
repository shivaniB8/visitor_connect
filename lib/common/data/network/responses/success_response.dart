import 'package:json_annotation/json_annotation.dart';

part 'success_response.g.dart';

@JsonSerializable(explicitToJson: true)
class SuccessResponse<T> {
  @JsonKey(name: 'success')
  final bool? success;

  @JsonKey(name: 'status')
  final int? status;

  @JsonKey(name: 'message')
  final String? message;

  @JsonKey(name: 'session_expired')
  final int? sessionExpired;

  @JsonKey(name: 'confidence')
  final int? confidence;

  SuccessResponse({
    this.success,
    this.confidence,
    this.status,
    this.message,
    this.sessionExpired,
  });

  factory SuccessResponse.fromJson(Map<String, dynamic> json) =>
      _$SuccessResponseFromJson<T>(json);

  Map<String, dynamic> toJson() => _$SuccessResponseToJson<T>(this);
}
