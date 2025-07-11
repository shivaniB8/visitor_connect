// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'module_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ModuleResponse _$ModuleResponseFromJson(Map<String, dynamic> json) =>
    ModuleResponse(
      success: json['success'] as bool?,
      status: json['status'] as int?,
      message: json['message'] as String?,
      data: (json['parentModules'] as List<dynamic>?)
          ?.map((e) => KeyValueResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      voterFk: json['mbk4'] as String?,
    );

Map<String, dynamic> _$ModuleResponseToJson(ModuleResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'status': instance.status,
      'message': instance.message,
      'mbk4': instance.voterFk,
      'parentModules': instance.data,
    };
