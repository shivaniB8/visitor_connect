import 'package:json_annotation/json_annotation.dart';

part 'outgoing_call_response.g.dart';

@JsonSerializable(explicitToJson: true)
class OutgoingCallResponse {
  @JsonKey(name: 'success')
  final bool? success;

  @JsonKey(name: 'message')
  final String? message;

  OutgoingCallResponse({
    this.success,
    this.message,
  });

  factory OutgoingCallResponse.fromJson(Map<String, dynamic> json) =>
      _$OutgoingCallResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OutgoingCallResponseToJson(this);
}
