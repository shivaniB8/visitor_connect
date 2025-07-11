import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'driving_licence_data.g.dart';

@JsonSerializable(explicitToJson: true)
class DrivingLicenseData extends Equatable {
  @JsonKey(name: 'as1')
  final int? id;

  @JsonKey(name: 'as2')
  final int? visitorFk;

  @JsonKey(name: 'as3')
  final String? nameOfVisitor;

  @JsonKey(name: 'as4')
  final String? drivingLicenseNo;

  @JsonKey(name: 'as5')
  final String? nameOnDrivingLicense;

  @JsonKey(name: 'as6')
  final String? permanentAdd;

  @JsonKey(name: 'as8')
  final String? currentAdd;

  @JsonKey(name: 'as7')
  final String? pincode;

  @JsonKey(name: 'as12')
  final int? gender;

  @JsonKey(name: 'as13')
  final String? dob;

  @JsonKey(name: 'as10')
  final String? rtoName;

  @JsonKey(name: 'as14')
  final String? expiryDate;

  @JsonKey(name: 'as19')
  final String? photo;

  const DrivingLicenseData({
    this.id,
    this.visitorFk,
    this.nameOfVisitor,
    this.drivingLicenseNo,
    this.nameOnDrivingLicense,
    this.permanentAdd,
    this.pincode,
    this.gender,
    this.currentAdd,
    this.dob,
    this.rtoName,
    this.expiryDate,
    this.photo,
  });

  factory DrivingLicenseData.fromJson(Map<String, dynamic> json) =>
      _$DrivingLicenseDataFromJson(json);

  Map<String, dynamic> toJson() => _$DrivingLicenseDataToJson(this);

  @override
  List<Object?> get props => [
        id,
        visitorFk,
        nameOfVisitor,
        drivingLicenseNo,
        nameOnDrivingLicense,
        permanentAdd,
        pincode,
        currentAdd,
        gender,
        dob,
        rtoName,
        expiryDate,
        photo,
      ];
}
