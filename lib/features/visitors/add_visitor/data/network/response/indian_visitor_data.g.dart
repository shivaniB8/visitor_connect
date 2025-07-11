// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'indian_visitor_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IndianVisitorData _$IndianVisitorDataFromJson(Map<String, dynamic> json) =>
    IndianVisitorData(
      message: json['message'] as String?,
      success: json['success'] as bool?,
      status: json['status'] as int?,
    );

Map<String, dynamic> _$IndianVisitorDataToJson(IndianVisitorData instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'status': instance.status,
    };
