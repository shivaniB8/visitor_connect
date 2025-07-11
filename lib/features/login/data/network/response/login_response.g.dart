// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) =>
    LoginResponse(
      data: json['data'] == null
          ? null
          : LoginUserDataResponse.fromJson(
              json['data'] as Map<String, dynamic>),
      message: json['message'] as String?,
      success: json['success'] as bool?,
      status: json['status'] as int?,
      logoutReason: json['logout_reason'] as int?,
      reLoginId: json['aq1'] as int?,
    );

Map<String, dynamic> _$LoginResponseToJson(LoginResponse instance) =>
    <String, dynamic>{
      'data': instance.data?.toJson(),
      'success': instance.success,
      'message': instance.message,
      'status': instance.status,
      'logout_reason': instance.logoutReason,
      'aq1': instance.reLoginId,
    };
