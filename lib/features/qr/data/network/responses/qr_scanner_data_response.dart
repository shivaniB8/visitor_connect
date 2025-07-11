import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'qr_scanner_data_response.g.dart';

@JsonSerializable(explicitToJson: true)
class QrScannerDataResponse extends Equatable {
  @JsonKey(name: 'aa1')
  final int? id;

  @JsonKey(name: 'aa2')
  final int? clientFk;

  @JsonKey(name: 'aa5')
  final String? title;

  @JsonKey(name: 'aa6')
  final String? firstName;

  @JsonKey(name: 'aa7')
  final String? middleName;

  @JsonKey(name: 'aa8')
  final String? lastName;

  @JsonKey(name: 'aa9')
  final String? fullName;

  @JsonKey(name: 'aa10')
  final String? dateOfBirth;

  @JsonKey(name: 'aa11')
  final int? age;

  @JsonKey(name: 'ab1')
  final int? historyId;

  @JsonKey(name: 'aa12')
  final int? gender;

  @JsonKey(name: 'aa13')
  final String? mobileNo;

  @JsonKey(name: 'aa14')
  final String? email;

  @JsonKey(name: 'aa20')
  final String? state;

  @JsonKey(name: 'aa22')
  final String? city;

  @JsonKey(name: 'aa24')
  final String? area;

  @JsonKey(name: 'aa25')
  final String? pincode;

  @JsonKey(name: 'aa18')
  final String? country;

  @JsonKey(name: 'aa32')
  final String? aadharImage;

  @JsonKey(name: 'aa29')
  final String? expiryDate;

  @JsonKey(name: 'aa42')
  final String? visitingFrom;

  @JsonKey(name: 'aa33')
  final String? aadharNo;

  @JsonKey(name: 'aa31')
  final String? aadharPhotoUrl;

  @JsonKey(name: 'aa36')
  final String? visitingReason;

  @JsonKey(name: 'aa26')
  final String? registrationDate;

  @JsonKey(name: 'aa30')
  final int? visitorType;

  @JsonKey(name: 'aa38')
  final String? qrImage;

  @JsonKey(name: 'aa39')
  final String? visaNumber;

  @JsonKey(name: 'ab7')
  final String? visaExitDate;
  @JsonKey(name: 'aa40')
  final String? visaExpiryDate;

  @JsonKey(name: 'aa41')
  final String? passportNo;

  @JsonKey(name: 'aa45')
  final String? address;

  @JsonKey(name: 'aa46')
  final String? image;

  @JsonKey(name: 'aa43')
  final String? visitingTill;

  @JsonKey(name: 'ab9')
  final String? branch;

  @JsonKey(name: 'z506')
  final String? updatedAt;

  @JsonKey(name: 'ab6')
  final String? entryDate;

  @JsonKey(name: 'z508')
  final String? lastUpdatedBy;

  @JsonKey(name: 'aa78')
  final int? bloodGrpFk;

  @JsonKey(name: 'aa79')
  final String? bloodGrp;

  @JsonKey(name: 'aa48')
  final int? visitingReasonFk;
  @JsonKey(name: 'aa49')
  final String? reasonValue;
  @JsonKey(name: 'ab10')
  final String? roomNo;

  @JsonKey(name: 'aa4')
  final int? fkTitle;

  @JsonKey(name: 'aa76')
  final String? passportBackPhoto;

  @JsonKey(name: 'aa74')
  final String? visaPhoto;

  @JsonKey(name: 'aa65')
  final String? passportFrontPhoto;

  @JsonKey(name: 'aw1')
  final int? aw1;

  @JsonKey(name: 'aw2')
  final int? aw2;

  @JsonKey(name: 'aw3')
  final String? aw3;

  @JsonKey(name: 'aw4')
  final int? aw4;

  @JsonKey(name: 'aw5')
  final String? aw5;

  @JsonKey(name: 'aw6')
  final int? aw6;

  @JsonKey(name: 'aw7')
  final String? aw7;

  @JsonKey(name: 'aw8')
  final String? aw8;

  @JsonKey(name: 'aw9')
  final String? aw9;

  @JsonKey(name: 'aw10')
  final int? aw10;

  @JsonKey(name: 'z501')
  final String? z501;

  @JsonKey(name: 'z502')
  final int? z502;

  @JsonKey(name: 'z503')
  final String? z503;

  @JsonKey(name: 'z504')
  final String? z504;

  @JsonKey(name: 'z505')
  final String? z505;

  @JsonKey(name: 'z507')
  final int? z507;

  @JsonKey(name: 'z509')
  final String? z509;

  @JsonKey(name: 'z510')
  final String? z510;

  @JsonKey(name: 'z511')
  final int? z511;

  @JsonKey(name: 'aw11')
  final String? aw11;

  @JsonKey(name: 'aw12')
  final String? aw12;
  @JsonKey(name: 'aa83')
  final int? businessType;

  const QrScannerDataResponse({
    this.id,
    this.dateOfBirth,
    this.clientFk,
    this.title,
    this.fullName,
    this.age,
    this.historyId,
    this.gender,
    this.mobileNo,
    this.email,
    this.aadharImage,
    this.country,
    this.address,
    this.image,
    this.registrationDate,
    this.expiryDate,
    this.aadharPhotoUrl,
    this.aadharNo,
    this.visitingReason,
    this.visaNumber,
    this.qrImage,
    this.visaExpiryDate,
    this.passportNo,
    this.branch,
    this.updatedAt,
    this.lastUpdatedBy,
    this.visitingFrom,
    this.entryDate,
    this.visitorType,
    this.visitingTill,
    this.bloodGrp,
    this.bloodGrpFk,
    this.visitingReasonFk,
    this.fkTitle,
    this.roomNo,
    this.firstName,
    this.middleName,
    this.lastName,
    this.visaPhoto,
    this.passportFrontPhoto,
    this.passportBackPhoto,
    this.visaExitDate,
    this.reasonValue,
    this.businessType,
    this.state,
    this.pincode,
    this.city,
    this.area,
    this.aw1,
    this.aw2,
    this.aw3,
    this.aw4,
    this.aw5,
    this.aw6,
    this.aw7,
    this.aw8,
    this.aw9,
    this.aw10,
    this.z501,
    this.z502,
    this.z503,
    this.z504,
    this.z505,
    this.z507,
    this.z509,
    this.z510,
    this.z511,
    this.aw11,
    this.aw12,
  });

  factory QrScannerDataResponse.fromJson(Map<String, dynamic> json) =>
      _$QrScannerDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$QrScannerDataResponseToJson(this);

  @override
  List<Object?> get props => [
        id,
        clientFk,
        title,
        dateOfBirth,
        fullName,
        age,
        address,
        gender,
        mobileNo,
        email,
        country,
        image,
        registrationDate,
        expiryDate,
        aadharNo,
        visitingReason,
        visaNumber,
        qrImage,
        visaExpiryDate,
        aadharImage,
        passportNo,
        branch,
        historyId,
        updatedAt,
        lastUpdatedBy,
        city,
        state,
        area,
        pincode,
        visitingFrom,
        entryDate,
        visitorType,
        visitingTill,
        bloodGrp,
        bloodGrpFk,
        visitingReasonFk,
        reasonValue,
        roomNo,
        fkTitle,
        firstName,
        middleName,
        lastName,
        visaPhoto,
        passportBackPhoto,
        passportFrontPhoto,
        visaExitDate,
        businessType,
        aw1,
        aw2,
        aw3,
        aw4,
        aw5,
        aw6,
        aw7,
        aw8,
        aw9,
        aw10,
        z501,
        z502,
        z503,
        z504,
        z505,
        z507,
        z509,
        aadharPhotoUrl,
        z510,
        z511,
        aw11,
        aw12,
      ];
}
