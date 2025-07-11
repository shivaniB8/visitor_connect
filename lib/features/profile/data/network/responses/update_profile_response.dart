import 'package:json_annotation/json_annotation.dart';

part 'update_profile_response.g.dart';

@JsonSerializable(explicitToJson: true)
class UpdateProfileResponse {
  @JsonKey(name: 'success')
  final bool? success;

  @JsonKey(name: 'status')
  final int? status;

  @JsonKey(name: 'message')
  final String? message;

  @JsonKey(name: 'msg')
  final String? msg;

  UpdateProfileResponse({
    this.success,
    this.status,
    this.message,
    this.msg,
  });

  factory UpdateProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$UpdateProfileResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateProfileResponseToJson(this);
}
