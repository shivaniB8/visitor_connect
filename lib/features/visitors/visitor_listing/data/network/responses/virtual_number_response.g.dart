// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'virtual_number_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VirtualNumberResponse _$VirtualNumberResponseFromJson(
        Map<String, dynamic> json) =>
    VirtualNumberResponse(
      success: json['success'] as bool?,
      status: json['status'] as int?,
      count: json['count'] as int?,
      records: (json['record'] as List<dynamic>?)
          ?.map(
              (e) => VirtualMobileResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$VirtualNumberResponseToJson(
        VirtualNumberResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'status': instance.status,
      'count': instance.count,
      'record': instance.records?.map((e) => e.toJson()).toList(),
    };
