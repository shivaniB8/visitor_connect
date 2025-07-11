// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'indian_visitor_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IndianVisitorResponse _$IndianVisitorResponseFromJson(
        Map<String, dynamic> json) =>
    IndianVisitorResponse(
      data: json['data'] == null
          ? null
          : IndianVisitorData.fromJson(json['data'] as Map<String, dynamic>),
      message: json['message'] as String?,
      success: json['success'] as bool?,
      status: json['status'] as int?,
    );

Map<String, dynamic> _$IndianVisitorResponseToJson(
        IndianVisitorResponse instance) =>
    <String, dynamic>{
      'data': instance.data?.toJson(),
      'success': instance.success,
      'message': instance.message,
      'status': instance.status,
    };
