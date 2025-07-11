import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'aadhar_data_response.g.dart';

@JsonSerializable(explicitToJson: true)
class AadharDataResponse extends Equatable {
  @JsonKey(name: 'ag1')
  final int? id;

  @JsonKey(name: 'ag2')
  final int? visitorFk;

  @JsonKey(name: 'aa29')
  final String? dateExpiry;

  @JsonKey(name: 'ag3')
  final String? aadharNumber;

  @JsonKey(name: 'ag4')
  final String? aadharName;

  @JsonKey(name: 'ag6')
  final String? aadharAddress;

  @JsonKey(name: 'aa32')
  final String? aadharPhoto;

  @JsonKey(name: 'aa46')
  final String? profilePhoto;

  @JsonKey(name: 'aa36')
  final String? visitingReason;

  @JsonKey(name: 'ag24')
  final int? gender;

  @JsonKey(name: 'aa13')
  final String? mobileNumber;

  @JsonKey(name: 'aa9')
  final String? fullName;

  @JsonKey(name: 'ab1')
  final int? historyId;

  @JsonKey(name: 'ag8')
  final String? dob;

  const AadharDataResponse(
      {this.id,
      this.visitorFk,
      this.aadharNumber,
      this.aadharName,
      this.historyId,
      this.aadharAddress,
      this.profilePhoto,
      this.aadharPhoto,
      this.gender,
      this.dateExpiry,
      this.mobileNumber,
      this.visitingReason,
      this.fullName,
      this.dob});

  factory AadharDataResponse.fromJson(Map<String, dynamic> json) =>
      _$AadharDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AadharDataResponseToJson(this);

  @override
  List<Object?> get props => [
        id,
        visitorFk,
        aadharNumber,
        historyId,
        aadharName,
        aadharAddress,
        profilePhoto,
        aadharPhoto,
        gender,
        dateExpiry,
        visitingReason,
        mobileNumber,
        fullName,
        dob
      ];
}
