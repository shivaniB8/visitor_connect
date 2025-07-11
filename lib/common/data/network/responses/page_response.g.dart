// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'page_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PageResponse<T> _$PageResponseFromJson<T>(Map<String, dynamic> json) =>
    PageResponse<T>(
      success: json['success'] as bool?,
      status: json['status'] as int?,
      count: json['count'] as int? ?? 0,
      message: json['message'] as String?,
      pageNo: json['page_no'] as int? ?? 0,
      content: (json['data'] as List<dynamic>?)
          ?.map((e) => _PageResponseConverter<T>().fromJson(e as Object))
          .toList(),
      liveBalance: json['live_balance'] as int?,
      sessionExpired: json['session_expired'] as int?,
    );

Map<String, dynamic> _$PageResponseToJson<T>(PageResponse<T> instance) =>
    <String, dynamic>{
      'success': instance.success,
      'status': instance.status,
      'count': instance.count,
      'message': instance.message,
      'page_no': instance.pageNo,
      'live_balance': instance.liveBalance,
      'session_expired': instance.sessionExpired,
      'data':
          instance.content?.map(_PageResponseConverter<T>().toJson).toList(),
    };
