// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_data_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginDataResponse _$LoginDataResponseFromJson(Map<String, dynamic> json) =>
    LoginDataResponse(
      branches: (json['host_branches_list'] as List<dynamic>?)
          ?.map((e) => KeyValueResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      ad1: json['ad1'] as int?,
      ad2: json['ad2'] as int?,
      ad3: json['ad3'] as String?,
      ad9: json['ad9'] as String?,
      ad22: json['ad22'] as String?,
    );

Map<String, dynamic> _$LoginDataResponseToJson(LoginDataResponse instance) =>
    <String, dynamic>{
      'host_branches_list': instance.branches?.map((e) => e.toJson()).toList(),
      'ad1': instance.ad1,
      'ad2': instance.ad2,
      'ad3': instance.ad3,
      'ad9': instance.ad9,
      'ad22': instance.ad22,
    };
