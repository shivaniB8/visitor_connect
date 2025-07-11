// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_info_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClientInfoResponse _$ClientInfoResponseFromJson(Map<String, dynamic> json) =>
    ClientInfoResponse(
      clientId: json['maa1'] as int?,
      clientName: json['maa2'] as String?,
      logo: json['maa6'] as String?,
      bucketName: json['maa24'] as String?,
    );

Map<String, dynamic> _$ClientInfoResponseToJson(ClientInfoResponse instance) =>
    <String, dynamic>{
      'maa1': instance.clientId,
      'maa2': instance.clientName,
      'maa6': instance.logo,
      'maa24': instance.bucketName,
    };
