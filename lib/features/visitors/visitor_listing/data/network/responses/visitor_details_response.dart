import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'visitor_details_response.g.dart';

@JsonSerializable(explicitToJson: true)
class VisitorDetailsResponse extends Equatable {
  @JsonKey(name: 'ab1')
  final int? id;

  @JsonKey(name: 'ab2')
  final int? visitorFk;

  @JsonKey(name: 'ab5')
  final String? clientName;

  @JsonKey(name: 'ab3')
  final String? fullName;

  @JsonKey(name: 'aa6')
  final String? firstName;

  @JsonKey(name: 'aa7')
  final String? middleName;

  @JsonKey(name: 'aa8')
  final String? lastName;

  @JsonKey(name: 'aa5')
  final String? title;

  @JsonKey(name: 'aa4')
  final int? fkTitle;

  @JsonKey(name: 'aa11')
  final int? age;

  @JsonKey(name: 'aa10')
  final String? birthDate;

  @JsonKey(name: 'aa12')
  final int? gender;

  @JsonKey(name: 'aa13')
  final String? mobileNo;

  @JsonKey(name: 'aa14')
  final String? email;

  @JsonKey(name: 'aa18')
  final String? country;

  @JsonKey(name: 'aa32')
  final String? aadharImage;

  @JsonKey(name: 'aa20')
  final String? state;

  @JsonKey(name: 'aa42')
  final String? visitingFrom;

  @JsonKey(name: 'ab6')
  final String? entryDate;

  @JsonKey(name: 'aa68')
  final String? mobileCountyCode;

  @JsonKey(name: 'aa29')
  final String? expiryDate;

  @JsonKey(name: 'aa30')
  final int? visitorType;

  @JsonKey(name: 'aa33')
  final String? aadharNo;

  @JsonKey(name: 'aa36')
  final String? visitingReason;

  @JsonKey(name: 'aa26')
  final String? registrationDate;

  @JsonKey(name: 'aa38')
  final String? qrImage;

  @JsonKey(name: 'aa39')
  final String? visaNumber;

  @JsonKey(name: 'ab7')
  final String? visitorExitDate;

  @JsonKey(name: 'aa41')
  final String? passportNo;

  @JsonKey(name: 'aa45')
  final String? address;

  @JsonKey(name: 'aa48')
  final int? visitingReasonFk;

  @JsonKey(name: 'formatted_aa43')
  final String? visitingTill;

  @JsonKey(name: 'aa46')
  final String? image;

  @JsonKey(name: 'aa40')
  final String? visaExpiryDate;

  @JsonKey(name: 'aa22')
  final String? city;

  @JsonKey(name: 'aa24')
  final String? area;

  @JsonKey(name: 'aa25')
  final String? pincode;

  @JsonKey(name: 'aa49')
  final String? reasonValue;

  @JsonKey(name: 'aa73')
  final String? criminalRocord;

  @JsonKey(name: 'ab9')
  final String? branch;

  @JsonKey(name: 'z506')
  final String? updatedAt;

  @JsonKey(name: 'z508')
  final String? lastUpdatedBy;

  @JsonKey(name: 'aa15')
  final String? profileImage;

  @JsonKey(name: 'aa58')
  final int? aadharVerifiedStatus;

  @JsonKey(name: 'aa78')
  final int? bloodGrpFk;

  @JsonKey(name: 'aa76')
  final String? passportBackPhoto;

  @JsonKey(name: 'aa74')
  final String? visaPhoto;

  @JsonKey(name: 'aa65')
  final String? passportFrontPhoto;

  @JsonKey(name: 'aa79')
  final String? bloodGrp;

  @JsonKey(name: 'aa59')
  final int? passportVerifiedStatus;

  @JsonKey(name: 'ab10')
  final String? roomNo;

  @JsonKey(name: 'aa83')
  final int? businessType;

  @JsonKey(name: 'short_name')
  final String? shortName;

  const VisitorDetailsResponse(
      {this.id,
      this.title,
      this.criminalRocord,
      this.city,
      this.area,
      this.pincode,
      this.fkTitle,
      this.entryDate,
      this.visitingFrom,
      this.bloodGrp,
      this.bloodGrpFk,
      this.visitorFk,
      this.clientName,
      this.visaExpiryDate,
      this.shortName,
      this.fullName,
      this.state,
      this.age,
      this.gender,
      this.visitorType,
      this.mobileNo,
      this.email,
      this.aadharImage,
      this.country,
      this.visitingTill,
      this.visitingReasonFk,
      this.address,
      this.image,
      this.registrationDate,
      this.expiryDate,
      this.reasonValue,
      this.aadharNo,
      this.visitingReason,
      this.visaNumber,
      this.qrImage,
      this.visitorExitDate,
      this.passportNo,
      this.branch,
      this.updatedAt,
      this.lastUpdatedBy,
      this.profileImage,
      this.aadharVerifiedStatus,
      this.passportVerifiedStatus,
      this.roomNo,
      this.mobileCountyCode,
      this.firstName,
      this.lastName,
      this.middleName,
      this.birthDate,
      this.visaPhoto,
      this.passportBackPhoto,
      this.passportFrontPhoto,
      this.businessType});

  factory VisitorDetailsResponse.fromJson(Map<String, dynamic> json) {
    return _$VisitorDetailsResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$VisitorDetailsResponseToJson(this);

  @override
  List<Object?> get props => [
        id,
        title,
        fkTitle,
        criminalRocord,
        visitorFk,
        clientName,
        visaExpiryDate,
        entryDate,
        visitorType,
        fullName,
        age,
        address,
        gender,
        mobileNo,
        bloodGrp,
        email,
        country,
        image,
        registrationDate,
        expiryDate,
        aadharNo,
        visitingReason,
        visitingFrom,
        visaNumber,
        qrImage,
        bloodGrpFk,
        visitorExitDate,
        aadharImage,
        passportNo,
        state,
        branch,
        updatedAt,
        city,
        area,
        pincode,
        lastUpdatedBy,
        mobileCountyCode,
        reasonValue,
        visitingTill,
        visitingReasonFk,
        profileImage,
        aadharVerifiedStatus,
        passportVerifiedStatus,
        roomNo,
        shortName,
        firstName,
        middleName,
        lastName,
        birthDate,
        visaPhoto,
        passportFrontPhoto,
        passportBackPhoto,
        businessType
      ];
}
