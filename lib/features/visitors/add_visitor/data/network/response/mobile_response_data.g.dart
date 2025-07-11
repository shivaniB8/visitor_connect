// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mobile_response_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MobileResponseData _$MobileResponseDataFromJson(Map<String, dynamic> json) =>
    MobileResponseData(
      visitorType: json['aa30'] as int?,
      id: json['aa1'] as int?,
      reasonBrief: json['aa36'] as String?,
      reasonFk: json['aa48'] as int?,
      visaNumber: json['aa39'] as String?,
      roomNo: json['ab10'] as String?,
      historyId: json['ab1'] as int?,
      fullName: json['aa9'] as String?,
      gender: json['aa12'] as int?,
      mobileNumber: json['aa13'] as String?,
      aadharNumber: json['aa33'] as String?,
      aadharPhoto: json['aa32'] as String?,
      reason: json['aa49'] as String?,
      address: json['aa45'] as String?,
      profilePhoto: json['aa46'] as String?,
      expireDate: json['aa29'] as String?,
      passportNumber: json['ap6'] as String?,
      dob: json['ap8'] as String?,
      visitorPassportNumber: json['aa41'] as String?,
      fileNumber: json['ap5'] as String?,
      qrImage: json['aa38'] as String?,
    );

Map<String, dynamic> _$MobileResponseDataToJson(MobileResponseData instance) =>
    <String, dynamic>{
      'aa1': instance.id,
      'aa9': instance.fullName,
      'aa12': instance.gender,
      'aa29': instance.expireDate,
      'aa13': instance.mobileNumber,
      'aa33': instance.aadharNumber,
      'aa32': instance.aadharPhoto,
      'aa46': instance.profilePhoto,
      'aa38': instance.qrImage,
      'aa45': instance.address,
      'aa36': instance.reasonBrief,
      'ab10': instance.roomNo,
      'aa48': instance.reasonFk,
      'aa49': instance.reason,
      'ap6': instance.passportNumber,
      'ap8': instance.dob,
      'aa41': instance.visitorPassportNumber,
      'ap5': instance.fileNumber,
      'aa30': instance.visitorType,
      'aa39': instance.visaNumber,
      'ab1': instance.historyId,
    };
