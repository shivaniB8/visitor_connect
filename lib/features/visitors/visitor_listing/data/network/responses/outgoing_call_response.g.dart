// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'outgoing_call_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OutgoingCallResponse _$OutgoingCallResponseFromJson(
        Map<String, dynamic> json) =>
    OutgoingCallResponse(
      success: json['success'] as bool?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$OutgoingCallResponseToJson(
        OutgoingCallResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
    };
