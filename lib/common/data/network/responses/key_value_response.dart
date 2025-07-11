import 'package:json_annotation/json_annotation.dart';
part 'key_value_response.g.dart';

@JsonSerializable()
class KeyValueResponse {
  @JsonKey(name: 'value')
  final int? value;

  @JsonKey(name: 'label')
  final String? label;

  @JsonKey(name: 'pincode')
  final String? pinCode;
  @JsonKey(name: 'branch_address')
  final String? branchAddress;

  @JsonKey(name: 'longitude')
  final double? longitude;

  @JsonKey(name: 'latitude')
  final double? latitude;

  KeyValueResponse(
      {this.value,
      this.label,
      this.longitude,
      this.latitude,
      this.pinCode,
      this.branchAddress});

  factory KeyValueResponse.fromJson(Map<String, dynamic> json) =>
      _$KeyValueResponseFromJson(json);

  Map<String, dynamic> toJson() => _$KeyValueResponseToJson(this);
}
