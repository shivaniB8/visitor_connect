// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'foreigner_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ForeignerData _$ForeignerDataFromJson(Map<String, dynamic> json) =>
    ForeignerData(
      visitorType: json['aa30'] as int?,
      visitorHistoryId: json['ab1'] as int?,
      id: json['aa1'] as int?,
      passportNumber: json['aa41'] as String?,
      fullName: json['aa9'] as String?,
      dob: json['aa10'] as String?,
      visitorPhotoUrl: json['aa15'] as String?,
      mobileNumber: json['aa13'] as String?,
      visitorFk: json['ab2'] as int?,
    );

Map<String, dynamic> _$ForeignerDataToJson(ForeignerData instance) =>
    <String, dynamic>{
      'aa1': instance.id,
      'ab2': instance.visitorFk,
      'aa41': instance.passportNumber,
      'aa9': instance.fullName,
      'aa10': instance.dob,
      'aa15': instance.visitorPhotoUrl,
      'aa30': instance.visitorType,
      'aa13': instance.mobileNumber,
      'ab1': instance.visitorHistoryId,
    };
