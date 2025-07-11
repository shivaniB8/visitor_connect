import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'foreigner_data.g.dart';

@JsonSerializable(explicitToJson: true)
class ForeignerData extends Equatable {
  @JsonKey(name: 'aa1')
  final int? id;

  @JsonKey(name: 'ab2')
  final int? visitorFk;
  @JsonKey(name: 'aa41')
  final String? passportNumber;

  @JsonKey(name: 'aa9')
  final String? fullName;

  @JsonKey(name: 'aa10')
  final String? dob;

  @JsonKey(name: 'aa15')
  final String? visitorPhotoUrl;

  @JsonKey(name: 'aa30')
  final int? visitorType;

  @JsonKey(name: 'aa13')
  final String? mobileNumber;

  @JsonKey(name: 'ab1')
  final int? visitorHistoryId;

  const ForeignerData(
      {this.visitorType,
      this.visitorHistoryId,
      this.id,
      this.passportNumber,
      this.fullName,
      this.dob,
      this.visitorPhotoUrl,
      this.mobileNumber,
      this.visitorFk});

  factory ForeignerData.fromJson(Map<String, dynamic> json) =>
      _$ForeignerDataFromJson(json);

  Map<String, dynamic> toJson() => _$ForeignerDataToJson(this);

  @override
  List<Object?> get props => [
        id,
        passportNumber,
        visitorType,
        fullName,
        dob,
        visitorPhotoUrl,
        visitorHistoryId,
        visitorFk
      ];
}
