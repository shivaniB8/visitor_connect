import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'mobile_response_data.g.dart';

@JsonSerializable(explicitToJson: true)
class MobileResponseData extends Equatable {
  @JsonKey(name: 'aa1')
  final int? id;

  @JsonKey(name: 'aa9')
  final String? fullName;

  @JsonKey(name: 'aa12')
  final int? gender;

  @JsonKey(name: 'aa29')
  final String? expireDate;

  @JsonKey(name: 'aa13')
  final String? mobileNumber;

  @JsonKey(name: 'aa33')
  final String? aadharNumber;

  @JsonKey(name: 'aa32')
  final String? aadharPhoto;

  @JsonKey(name: 'aa46')
  final String? profilePhoto;

  @JsonKey(name: 'aa38')
  final String? qrImage;

  @JsonKey(name: 'aa45')
  final String? address;

  @JsonKey(name: 'aa36')
  final String? reasonBrief;

  @JsonKey(name: 'ab10')
  final String? roomNo;

  @JsonKey(name: 'aa48')
  final int? reasonFk;

  @JsonKey(name: 'aa49')
  final String? reason;

  @JsonKey(name: 'ap6')
  final String? passportNumber;

  @JsonKey(name: 'ap8')
  final String? dob;

  @JsonKey(name: 'aa41')
  final String? visitorPassportNumber;

  @JsonKey(name: 'ap5')
  final String? fileNumber;

  @JsonKey(name: 'aa30')
  final int? visitorType;

  @JsonKey(name: 'aa39')
  final String? visaNumber;

  @JsonKey(name: 'ab1')
  final int? historyId;

  const MobileResponseData({
    this.visitorType,
    this.id,
    this.reasonBrief,
    this.reasonFk,
    this.visaNumber,
    this.roomNo,
    this.historyId,
    this.fullName,
    this.gender,
    this.mobileNumber,
    this.aadharNumber,
    this.aadharPhoto,
    this.reason,
    this.address,
    this.profilePhoto,
    this.expireDate,
    this.passportNumber,
    this.dob,
    this.visitorPassportNumber,
    this.fileNumber,
    this.qrImage,
  });

  factory MobileResponseData.fromJson(Map<String, dynamic> json) =>
      _$MobileResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$MobileResponseDataToJson(this);

  @override
  List<Object?> get props => [
        id,
        visitorType,
        fullName,
        mobileNumber,
        aadharNumber,
        reason,
        address,
        historyId,
        reasonBrief,
        roomNo,
        reasonFk,
        gender,
        profilePhoto,
        expireDate,
        passportNumber,
        dob,
        visitorPassportNumber,
        fileNumber,
        aadharPhoto,
        visaNumber,
        qrImage
      ];
}
