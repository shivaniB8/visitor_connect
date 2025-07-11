// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_foreigner_visitor_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddForeignerVisitorResponse _$AddForeignerVisitorResponseFromJson(
        Map<String, dynamic> json) =>
    AddForeignerVisitorResponse(
      success: json['success'] as bool?,
      statusCode: json['status'] as int?,
      message: json['message'] as String?,
      foreignerData: json['data'] == null
          ? null
          : ForeignerData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AddForeignerVisitorResponseToJson(
        AddForeignerVisitorResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'status': instance.statusCode,
      'message': instance.message,
      'data': instance.foreignerData?.toJson(),
    };
