import 'package:json_annotation/json_annotation.dart';

part 'update_profile_request.g.dart';

@JsonSerializable(explicitToJson: true)
class UpdateProfileRequest {
  @JsonKey(name: 'ad5')
  final String? title;

  @JsonKey(name: 'ad4')
  final int? fkTitle;

  @JsonKey(name: 'ad1')
  final int? userId;

  @JsonKey(name: 'ad9')
  final String? fullName;

  @JsonKey(name: 'ad18')
  final String? email;

  @JsonKey(name: 'ad30')
  final String? address;

  const UpdateProfileRequest({
    this.userId,
    this.title,
    this.fkTitle,
    this.fullName,
    this.email,
    this.address,
  });

  factory UpdateProfileRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateProfileRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateProfileRequestToJson(this);
}
