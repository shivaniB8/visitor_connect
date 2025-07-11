// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driving_licence_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DrivingLicenseData _$DrivingLicenseDataFromJson(Map<String, dynamic> json) =>
    DrivingLicenseData(
      id: json['as1'] as int?,
      visitorFk: json['as2'] as int?,
      nameOfVisitor: json['as3'] as String?,
      drivingLicenseNo: json['as4'] as String?,
      nameOnDrivingLicense: json['as5'] as String?,
      permanentAdd: json['as6'] as String?,
      pincode: json['as7'] as String?,
      gender: json['as12'] as int?,
      currentAdd: json['as8'] as String?,
      dob: json['as13'] as String?,
      rtoName: json['as10'] as String?,
      expiryDate: json['as14'] as String?,
      photo: json['as19'] as String?,
    );

Map<String, dynamic> _$DrivingLicenseDataToJson(DrivingLicenseData instance) =>
    <String, dynamic>{
      'as1': instance.id,
      'as2': instance.visitorFk,
      'as3': instance.nameOfVisitor,
      'as4': instance.drivingLicenseNo,
      'as5': instance.nameOnDrivingLicense,
      'as6': instance.permanentAdd,
      'as8': instance.currentAdd,
      'as7': instance.pincode,
      'as12': instance.gender,
      'as13': instance.dob,
      'as10': instance.rtoName,
      'as14': instance.expiryDate,
      'as19': instance.photo,
    };
