import 'package:equatable/equatable.dart';
import 'package:host_visitor_connect/features/report/report_list/data/network/responses/report_list_response.dart';

class Report extends Equatable {
  final int? id;
  final int? visitorFk;
  final String? visitorFkValue;
  final int? userFk;
  final String? reportedUserName;
  final int? reasonFk;
  final String? reasonValue;
  final String? reportDetails;
  final int? userType;
  final String? timeReported;
  final String? updatedAt;
  final String? updatedBy;
  final int? titleFk;
  final String? title;
  final String? dateOfBirth;
  final int? age;
  final int? gender;
  final String? mobileNumber;
  final String? email;
  final String? country;
  final String? expiryDate;
  final int? visitorType;
  final String? aadharPhoto;
  final String? aadharNumber;
  final String? stayingAt;
  final String? reasonToVisit;
  final String? qrPhoto;
  final String? visaNumber;
  final String? visaExpiry;
  final String? passportNumber;
  final String? visitingFrom;
  final String? visitingTill;
  final String? address;
  final String? visitorPhoto;
  final String? reasonValueVisit;
  final int? reasonFkVisit;
  final String? countryCode;
  final int? visitorId;
  final int? aadharVerifiedStatus;
  final int? passportVerifiedStatus;
  final String? reportImage;
  final String? registrationDate;
  final String? roomNo;
  final String? pincode;
  final String? area;
  final String? city;
  final String? shortName;

  const Report({
    this.id,
    this.visitorFk,
    this.visitorFkValue,
    this.roomNo,
    this.userFk,
    this.reportedUserName,
    this.timeReported,
    this.reportDetails,
    this.reasonValue,
    this.reasonFk,
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
    this.countryCode,
    this.aadharPhoto,
    this.aadharNumber,
    this.stayingAt,
    this.reasonToVisit,
    this.qrPhoto,
    this.visaNumber,
    this.visaExpiry,
    this.passportNumber,
    this.visitingFrom,
    this.visitingTill,
    this.address,
    this.visitorPhoto,
    this.reasonValueVisit,
    this.reasonFkVisit,
    this.visitorId,
    this.aadharVerifiedStatus,
    this.passportVerifiedStatus,
    this.reportImage,
    this.registrationDate,
    this.area,
    this.city,
    this.pincode,
    this.shortName,
  });

  factory Report.fromApiResponse(
    ReportListResponse reportListResponse,
  ) {
    return Report(
      id: reportListResponse.id,
      visitorFkValue: reportListResponse.visitorFkValue,
      visitorFk: reportListResponse.visitorFk,
      userFk: reportListResponse.userFk,
      reportedUserName: reportListResponse.reportedUserName,
      reasonFk: reportListResponse.reasonFk,
      reasonValue: reportListResponse.reasonValue,
      reportDetails: reportListResponse.reportDetails,
      timeReported: reportListResponse.timeReported,
      userType: reportListResponse.userType,
      updatedBy: reportListResponse.updatedBy,
      updatedAt: reportListResponse.updatedAt,
      title: reportListResponse.title,
      titleFk: reportListResponse.titleFk,
      dateOfBirth: reportListResponse.dateOfBirth,
      gender: reportListResponse.gender,
      mobileNumber: reportListResponse.mobileNumber,
      email: reportListResponse.email,
      age: reportListResponse.age,
      country: reportListResponse.country,
      expiryDate: reportListResponse.expiryDate,
      visitorType: reportListResponse.visitorType,
      aadharPhoto: reportListResponse.aadharPhoto,
      aadharNumber: reportListResponse.aadharNumber,
      stayingAt: reportListResponse.stayingAt,
      reasonToVisit: reportListResponse.reasonToVisit,
      qrPhoto: reportListResponse.qrPhoto,
      visaNumber: reportListResponse.visaNumber,
      visaExpiry: reportListResponse.visaExpiry,
      passportNumber: reportListResponse.passportNumber,
      visitingFrom: reportListResponse.visitingFrom,
      visitingTill: reportListResponse.visitingTill,
      address: reportListResponse.address,
      visitorPhoto: reportListResponse.visitorPhoto,
      reasonValueVisit: reportListResponse.reasonValueVisit,
      reasonFkVisit: reportListResponse.reasonFkVisit,
      countryCode: reportListResponse.countryCode,
      visitorId: reportListResponse.visitorId,
      passportVerifiedStatus: reportListResponse.passportVerifiedStatus,
      aadharVerifiedStatus: reportListResponse.aadharVerifiedStatus,
      reportImage: reportListResponse.reportImage,
      registrationDate: reportListResponse.registrationDate,
      roomNo: reportListResponse.roomNo,
      city: reportListResponse.city,
      area: reportListResponse.area,
      pincode: reportListResponse.pincode,
      shortName: reportListResponse.shortName,
    );
  }

  @override
  List<Object?> get props => [
        id,
        visitorFk,
        visitorFkValue,
        userFk,
        reportedUserName,
        timeReported,
        reportDetails,
        reasonValue,
        reasonFk,
        userType,
        updatedAt,
        updatedBy,
        titleFk,
        title,
        dateOfBirth,
        gender,
        mobileNumber,
        email,
        age,
        country,
        expiryDate,
        visitorType,
        aadharPhoto,
        aadharNumber,
        stayingAt,
        reasonToVisit,
        qrPhoto,
        visaNumber,
        visaExpiry,
        passportNumber,
        visitingFrom,
        visitingTill,
        address,
        countryCode,
        visitorPhoto,
        reasonValueVisit,
        reasonFkVisit,
        visitorId,
        aadharVerifiedStatus,
        passportVerifiedStatus,
        reportImage,
        registrationDate,
        roomNo,
        city,
        area,
        pincode,
        shortName,
      ];
}
