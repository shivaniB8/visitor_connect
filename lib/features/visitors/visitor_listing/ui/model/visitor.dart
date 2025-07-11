import 'package:equatable/equatable.dart';
import 'package:host_visitor_connect/features/visitors/history/data/network/responses/visitor_room_response.dart';
import 'package:host_visitor_connect/features/visitors/visitor_listing/data/network/responses/visitor_details_response.dart';

class Visitor extends Equatable {
  final int? id;
  final int? visitorFk;
  final int? fkTitle;
  final String? title;
  final String? clientName;
  final String? fullName;
  final int? age;
  final int? gender;
  final String? mobileNo;
  final String? email;
  final String? country;
  final String? image;
  final String? registrationDate;
  final String? expiryDate;
  final String? aadharNo;
  final String? visitingReason;
  final String? visaNumber;
  final String? visaExpiryDate;
  final String? visitorExitDate;
  final String? passportNo;
  final String? qrImage;
  final String? aadharImage;
  final String? address;
  final int? visitorType;
  final String? entryDate;
  final String? lastUpdatedBy;
  final String? updatedAt;
  final String? reasonValue;
  final int? visitingReasonFk;
  final String? visitingTill;
  final String? profileImage;
  final int? aadharVerifiedStatus;
  final int? passportVerifiedStatus;
  final String? roomNo;
  final String? criminalRecord;
  final String? shortName;
  final String? bloodGrp;
  final int? bloodGrpFk;
  final String? visitingFrom;
  final String? mobileCountyCode;
  final String? pincode;
  final String? area;
  final String? city;
  final String? state;
  final String? firstName;
  final String? middleName;
  final String? lastName;
  final String? birthDate;
  final String? passportBackPhoto;
  final String? visaPhoto;
  final String? passportFrontPhoto;
  final int? businessType;

  const Visitor(
      {this.id,
      this.bloodGrp,
      this.bloodGrpFk,
      this.visitingFrom,
      this.pincode,
      this.area,
      this.city,
      this.visitorFk,
      this.criminalRecord,
      this.fkTitle,
      this.shortName,
      this.clientName,
      this.fullName,
      this.age,
      this.gender,
      this.mobileNo,
      this.email,
      this.country,
      this.mobileCountyCode,
      this.image,
      this.registrationDate,
      this.expiryDate,
      this.aadharNo,
      this.visitingReason,
      this.visaNumber,
      this.visitorExitDate,
      this.passportNo,
      this.qrImage,
      this.aadharImage,
      this.address,
      this.entryDate,
      this.visitorType,
      this.lastUpdatedBy,
      this.updatedAt,
      this.reasonValue,
      this.visitingReasonFk,
      this.visitingTill,
      this.profileImage,
      this.aadharVerifiedStatus,
      this.passportVerifiedStatus,
      this.roomNo,
      this.state,
      this.visaExpiryDate,
      this.title,
      this.firstName,
      this.middleName,
      this.birthDate,
      this.lastName,
      this.visaPhoto,
      this.passportBackPhoto,
      this.passportFrontPhoto,
      this.businessType});

  factory Visitor.fromApiResponse(
    VisitorDetailsResponse visitorDetailsResponse,
  ) {
    return Visitor(
        visitingFrom: visitorDetailsResponse.visitingFrom,
        id: visitorDetailsResponse.id,
        fullName: visitorDetailsResponse.fullName,
        state: visitorDetailsResponse.state,
        visitorFk: visitorDetailsResponse.visitorFk,
        fkTitle: visitorDetailsResponse.fkTitle,
        clientName: visitorDetailsResponse.clientName,
        age: visitorDetailsResponse.age,
        gender: visitorDetailsResponse.gender,
        mobileNo: visitorDetailsResponse.mobileNo,
        email: visitorDetailsResponse.email,
        visitorType: visitorDetailsResponse.visitorType,
        country: visitorDetailsResponse.country,
        image: visitorDetailsResponse.image,
        city: visitorDetailsResponse.city,
        area: visitorDetailsResponse.area,
        pincode: visitorDetailsResponse.pincode,
        registrationDate: visitorDetailsResponse.registrationDate,
        expiryDate: visitorDetailsResponse.expiryDate,
        bloodGrp: visitorDetailsResponse.bloodGrp,
        aadharNo: visitorDetailsResponse.aadharNo,
        visitingReason: visitorDetailsResponse.visitingReason,
        visaNumber: visitorDetailsResponse.visaNumber,
        visitorExitDate: visitorDetailsResponse.visitorExitDate,
        passportNo: visitorDetailsResponse.passportNo,
        qrImage: visitorDetailsResponse.qrImage,
        aadharImage: visitorDetailsResponse.aadharImage,
        address: visitorDetailsResponse.address,
        entryDate: visitorDetailsResponse.entryDate,
        lastUpdatedBy: visitorDetailsResponse.lastUpdatedBy,
        updatedAt: visitorDetailsResponse.updatedAt,
        visitingReasonFk: visitorDetailsResponse.visitingReasonFk,
        visitingTill: visitorDetailsResponse.visitingTill,
        reasonValue: visitorDetailsResponse.reasonValue,
        profileImage: visitorDetailsResponse.profileImage,
        aadharVerifiedStatus: visitorDetailsResponse.aadharVerifiedStatus,
        passportVerifiedStatus: visitorDetailsResponse.passportVerifiedStatus,
        roomNo: visitorDetailsResponse.roomNo,
        criminalRecord: visitorDetailsResponse.criminalRocord,
        shortName: visitorDetailsResponse.shortName,
        mobileCountyCode: visitorDetailsResponse.mobileCountyCode,
        visaExpiryDate: visitorDetailsResponse.visaExpiryDate,
        bloodGrpFk: visitorDetailsResponse.bloodGrpFk,
        firstName: visitorDetailsResponse.firstName,
        lastName: visitorDetailsResponse.lastName,
        middleName: visitorDetailsResponse.middleName,
        birthDate: visitorDetailsResponse.birthDate,
        title: visitorDetailsResponse.title,
        visaPhoto: visitorDetailsResponse.visaPhoto,
        passportBackPhoto: visitorDetailsResponse.passportBackPhoto,
        passportFrontPhoto: visitorDetailsResponse.passportFrontPhoto,
        businessType: visitorDetailsResponse.businessType);
  }

  @override
  List<Object?> get props => [
        id,
        visitorFk,
        clientName,
        fullName,
        age,
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
        visitorExitDate,
        passportNo,
        qrImage,
        visitingFrom,
        aadharImage,
        address,
        entryDate,
        lastUpdatedBy,
        updatedAt,
        reasonValue,
        visitingReasonFk,
        visitingTill,
        profileImage,
        aadharVerifiedStatus,
        bloodGrp,
        bloodGrpFk,
        passportVerifiedStatus,
        fkTitle,
        shortName,
        city,
        area,
        pincode,
        mobileCountyCode,
        visaExpiryDate,
        title,
        firstName,
        middleName,
        lastName,
        reasonValue,
        birthDate,
        visaPhoto,
        passportFrontPhoto,
        passportBackPhoto,
        businessType
      ];
}

class Room extends Equatable {
  final String? roomNo;
  final String? date;
  final List<VisitorDetailsResponse>? visitors;

  const Room({
    this.roomNo,
    this.date,
    this.visitors,
  });

  factory Room.fromApiResponse(
    VisitorRoomResponse visitorRoomResponse,
  ) {
    return Room(
      roomNo: visitorRoomResponse.roomNo,
      date: visitorRoomResponse.date,
      visitors: visitorRoomResponse.visitors,
    );
  }

  @override
  List<Object?> get props => [
        roomNo,
        date,
        visitors,
      ];
}
