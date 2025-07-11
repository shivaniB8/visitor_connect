// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_branch_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginBranchResponse _$LoginBranchResponseFromJson(Map<String, dynamic> json) =>
    LoginBranchResponse(
      json['master_bucket_name'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => LoginDataResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: json['status'] as int?,
      message: json['message'] as String?,
      success: json['success'] as bool?,
    );

Map<String, dynamic> _$LoginBranchResponseToJson(
        LoginBranchResponse instance) =>
    <String, dynamic>{
      'data': instance.data?.map((e) => e.toJson()).toList(),
      'success': instance.success,
      'master_bucket_name': instance.masterBucketName,
      'message': instance.message,
      'status': instance.status,
    };
