// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'virtual_mobile_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VirtualMobileResponse _$VirtualMobileResponseFromJson(
        Map<String, dynamic> json) =>
    VirtualMobileResponse(
      virtualNumber: json['cn2'] as String?,
      actualNumber: json['mobile_one'] as String?,
      settingId: json['cn1'] as int?,
    );

Map<String, dynamic> _$VirtualMobileResponseToJson(
        VirtualMobileResponse instance) =>
    <String, dynamic>{
      'cn2': instance.virtualNumber,
      'mobile_one': instance.actualNumber,
      'cn1': instance.settingId,
    };
