// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'aadhar_data_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AadharDataResponse _$AadharDataResponseFromJson(Map<String, dynamic> json) =>
    AadharDataResponse(
      id: json['ag1'] as int?,
      visitorFk: json['ag2'] as int?,
      aadharNumber: json['ag3'] as String?,
      aadharName: json['ag4'] as String?,
      historyId: json['ab1'] as int?,
      aadharAddress: json['ag6'] as String?,
      profilePhoto: json['aa46'] as String?,
      aadharPhoto: json['aa32'] as String?,
      gender: json['ag24'] as int?,
      dateExpiry: json['aa29'] as String?,
      mobileNumber: json['aa13'] as String?,
      visitingReason: json['aa36'] as String?,
      fullName: json['aa9'] as String?,
      dob: json['ag8'] as String?,
    );

Map<String, dynamic> _$AadharDataResponseToJson(AadharDataResponse instance) =>
    <String, dynamic>{
      'ag1': instance.id,
      'ag2': instance.visitorFk,
      'aa29': instance.dateExpiry,
      'ag3': instance.aadharNumber,
      'ag4': instance.aadharName,
      'ag6': instance.aadharAddress,
      'aa32': instance.aadharPhoto,
      'aa46': instance.profilePhoto,
      'aa36': instance.visitingReason,
      'ag24': instance.gender,
      'aa13': instance.mobileNumber,
      'aa9': instance.fullName,
      'ab1': instance.historyId,
      'ag8': instance.dob,
    };
