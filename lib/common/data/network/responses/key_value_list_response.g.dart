// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'key_value_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KeyValueListResponse _$KeyValueListResponseFromJson(
        Map<String, dynamic> json) =>
    KeyValueListResponse(
      success: json['success'] as bool?,
      status: json['status'] as int?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => KeyValueResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      voterFk: json['mbk4'] as String?,
    );

Map<String, dynamic> _$KeyValueListResponseToJson(
        KeyValueListResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'status': instance.status,
      'message': instance.message,
      'mbk4': instance.voterFk,
      'data': instance.data,
    };
