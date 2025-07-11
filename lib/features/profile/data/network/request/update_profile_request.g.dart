// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_profile_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateProfileRequest _$UpdateProfileRequestFromJson(
        Map<String, dynamic> json) =>
    UpdateProfileRequest(
      userId: json['ad1'] as int?,
      title: json['ad5'] as String?,
      fkTitle: json['ad4'] as int?,
      fullName: json['ad9'] as String?,
      email: json['ad18'] as String?,
      address: json['ad30'] as String?,
    );

Map<String, dynamic> _$UpdateProfileRequestToJson(
        UpdateProfileRequest instance) =>
    <String, dynamic>{
      'ad5': instance.title,
      'ad4': instance.fkTitle,
      'ad1': instance.userId,
      'ad9': instance.fullName,
      'ad18': instance.email,
      'ad30': instance.address,
    };
