// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'users_data_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UsersDataResponse _$UsersDataResponseFromJson(Map<String, dynamic> json) =>
    UsersDataResponse(
      id: json['ad1'] as int?,
      hostFk: json['ad2'] as int?,
      titleFk: json['ad4'] as int?,
      title: json['ad5'] as String?,
      emailId: json['ad18'] as String?,
      fullName: json['ad9'] as String?,
      designation: json['ad11'] as String?,
      age: json['ad13'] as int?,
      gender: json['ad14'] as int?,
      birthDate: json['ad12'] as String?,
      photo: json['ad22'] as String?,
      role: json['ad27'] as String?,
      mobileNumber: json['ad15'] as String?,
      address: json['ad30'] as String?,
      branchValue: json['branchcategory'] as int?,
      updatedAt: json['z506'] as String?,
      updatedBy: json['z508'] as String?,
      businessType: json['business_type'] as String?,
    );

Map<String, dynamic> _$UsersDataResponseToJson(UsersDataResponse instance) =>
    <String, dynamic>{
      'ad1': instance.id,
      'ad2': instance.hostFk,
      'ad4': instance.titleFk,
      'ad5': instance.title,
      'ad9': instance.fullName,
      'ad11': instance.designation,
      'ad13': instance.age,
      'ad14': instance.gender,
      'ad18': instance.emailId,
      'ad12': instance.birthDate,
      'ad22': instance.photo,
      'ad27': instance.role,
      'ad15': instance.mobileNumber,
      'ad30': instance.address,
      'branchcategory': instance.branchValue,
      'z506': instance.updatedAt,
      'z508': instance.updatedBy,
      'business_type': instance.businessType,
    };
