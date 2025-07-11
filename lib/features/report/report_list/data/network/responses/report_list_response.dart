import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'report_list_response.g.dart';

@JsonSerializable(explicitToJson: true)
class ReportListResponse extends Equatable {
  @JsonKey(name: 'aw1')
  final int? id;

  @JsonKey(name: 'aw2')
  final int? visitorFk;

  @JsonKey(name: 'aw3')
  final String? visitorFkValue;

  @JsonKey(name: 'aw4')
  final int? userFk;

  @JsonKey(name: 'aw5')
  final String? reportedUserName;

  @JsonKey(name: 'aw6')
  final int? reasonFk;

  @JsonKey(name: 'aw7')
  final String? reasonValue;

  @JsonKey(name: 'aw8')
  final String? reportDetails;

  @JsonKey(name: 'aw9')
  final String? timeReported;

  @JsonKey(name: 'aw10')
  final int? userType;

  @JsonKey(name: 'aw11')
  final String? reportImage;

  @JsonKey(name: 'z506')
  final String? updatedAt;

  @JsonKey(name: 'z508')
  final String? updatedBy;

  @JsonKey(name: 'aa4')
  final int? titleFk;

  @JsonKey(name: 'aa5')
  final String? title;

  @JsonKey(name: 'aa10')
  final String? dateOfBirth;

  @JsonKey(name: 'aa11')
  final int? age;

  @JsonKey(name: 'aa12')
  final int? gender;

  @JsonKey(name: 'aa13')
  final String? mobileNumber;

  @JsonKey(name: 'aa14')
  final String? email;

  @JsonKey(name: 'aa18')
  final String? country;

  @JsonKey(name: 'aa29')
  final String? expiryDate;

  @JsonKey(name: 'aa30')
  final int? visitorType;

  @JsonKey(name: 'aa32')
  final String? aadharPhoto;

  @JsonKey(name: 'aa33')
  final String? aadharNumber;

  @JsonKey(name: 'aa35')
  final String? stayingAt;

  @JsonKey(name: 'aa36')
  final String? reasonToVisit;

  @JsonKey(name: 'aa38')
  final String? qrPhoto;

  @JsonKey(name: 'aa39')
  final String? visaNumber;

  @JsonKey(name: 'aa40')
  final String? visaExpiry;

  @JsonKey(name: 'aa41')
  final String? passportNumber;

  @JsonKey(name: 'aa42')
  final String? visitingFrom;

  @JsonKey(name: 'aa43')
  final String? visitingTill;

  @JsonKey(name: 'aa44')
  final String? countryCode;

  @JsonKey(name: 'aa45')
  final String? address;

  @JsonKey(name: 'aa46')
  final String? visitorPhoto;

  @JsonKey(name: 'aa49')
  final String? reasonValueVisit;

  @JsonKey(name: 'aa48')
  final int? reasonFkVisit;

  @JsonKey(name: 'aa1')
  final int? visitorId;

  @JsonKey(name: 'aa58')
  final int? aadharVerifiedStatus;

  @JsonKey(name: 'aa59')
  final int? passportVerifiedStatus;

  @JsonKey(name: 'aa26')
  final String? registrationDate;

  @JsonKey(name: 'ab10')
  final String? roomNo;

  @JsonKey(name: 'aa22')
  final String? city;

  @JsonKey(name: 'aa24')
  final String? area;

  @JsonKey(name: 'aa25')
  final String? pincode;

  @JsonKey(name: 'short_name')
  final String? shortName;

  const ReportListResponse({
    this.id,
    this.visitorFk,
    this.visitorFkValue,
    this.userFk,
    this.reportedUserName,
    this.reasonFk,
    this.roomNo,
    this.reasonValue,
    this.reportDetails,
    this.timeReported,
    this.userType,
    this.updatedAt,
    this.updatedBy,
    this.titleFk,
    this.title,
    this.dateOfBirth,
    this.age,
    this.gender,
    this.mobileNumber,
    this.email,
    this.country,
    this.expiryDate,
    this.visitorType,
    this.aadharPhoto,
    this.aadharNumber,
    this.stayingAt,
    this.reasonToVisit,
    this.qrPhoto,
    this.visaNumber,
    this.visaExpiry,
    this.passportNumber,
    this.countryCode,
    this.visitingFrom,
    this.visitingTill,
    this.address,
    this.visitorPhoto,
    this.reasonValueVisit,
    this.reasonFkVisit,
    this.visitorId,
    this.passportVerifiedStatus,
    this.aadharVerifiedStatus,
    this.reportImage,
    this.registrationDate,
    this.pincode,
    this.city,
    this.area,
    this.shortName,
  });

  factory ReportListResponse.fromJson(Map<String, dynamic> json) =>
      _$ReportListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ReportListResponseToJson(this);

  @override
  List<Object?> get props => [
        id,
        visitorFk,
        visitorFkValue,
        roomNo,
        userFk,
        reportedUserName,
        reasonFk,
        reasonValue,
        reportDetails,
        timeReported,
        userType,
        updatedAt,
        updatedBy,
        titleFk,
        title,
        dateOfBirth,
        age,
        gender,
        mobileNumber,
        email,
        country,
        expiryDate,
        visitorType,
        aadharPhoto,
        aadharNumber,
        countryCode,
        stayingAt,
        reasonToVisit,
        qrPhoto,
        visaNumber,
        visaExpiry,
        passportNumber,
        visitingFrom,
        visitingTill,
        address,
        visitorPhoto,
        reasonValueVisit,
        reasonFkVisit,
        visitorId,
        aadharVerifiedStatus,
        passportVerifiedStatus,
        reportImage,
        registrationDate,
        area,
        pincode,
        city,
        shortName,
      ];
}
