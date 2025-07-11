// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_user_data_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginUserDataResponse _$LoginUserDataResponseFromJson(
        Map<String, dynamic> json) =>
    LoginUserDataResponse(
      userReference: json['user_reference'] as String?,
      clientInfo: json['client_info'] == null
          ? null
          : ClientInfoResponse.fromJson(
              json['client_info'] as Map<String, dynamic>),
      masterBucket: json['master_bucket_name'] as String?,
    );

Map<String, dynamic> _$LoginUserDataResponseToJson(
        LoginUserDataResponse instance) =>
    <String, dynamic>{
      'user_reference': instance.userReference,
      'client_info': instance.clientInfo?.toJson(),
      'master_bucket_name': instance.masterBucket,
    };
