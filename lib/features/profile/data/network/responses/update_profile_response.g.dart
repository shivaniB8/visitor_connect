// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_profile_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateProfileResponse _$UpdateProfileResponseFromJson(
        Map<String, dynamic> json) =>
    UpdateProfileResponse(
      success: json['success'] as bool?,
      status: json['status'] as int?,
      message: json['message'] as String?,
      msg: json['msg'] as String?,
    );

Map<String, dynamic> _$UpdateProfileResponseToJson(
        UpdateProfileResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'status': instance.status,
      'message': instance.message,
      'msg': instance.msg,
    };
