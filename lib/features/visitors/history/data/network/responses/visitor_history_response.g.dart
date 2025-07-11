// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'visitor_history_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VisitorHistoryResponse _$VisitorHistoryResponseFromJson(
        Map<String, dynamic> json) =>
    VisitorHistoryResponse(
      id: json['ab1'] as int?,
      visitorFk: json['ab2'] as int?,
      hostFk: json['ab4'] as int?,
      entryDateTime: json['ab6'] as String?,
      exitDateTime: json['ab7'] as String?,
      branchFk: json['ab8'] as int?,
      branchValue: json['ab9'] as String?,
      updatedAt: json['z506'] as String?,
      visitorFkValue: json['ab3'] as String?,
      updatedBy: json['z508'] as String?,
      hostFkValue: json['ab5'] as String?,
      reasonFkValue: json['ab13'] as int?,
      reasonValue: json['ab14'] as String?,
      briefReason: json['ab15'] as String?,
    );

Map<String, dynamic> _$VisitorHistoryResponseToJson(
        VisitorHistoryResponse instance) =>
    <String, dynamic>{
      'ab1': instance.id,
      'ab2': instance.visitorFk,
      'ab3': instance.visitorFkValue,
      'ab4': instance.hostFk,
      'ab6': instance.entryDateTime,
      'ab7': instance.exitDateTime,
      'ab8': instance.branchFk,
      'ab9': instance.branchValue,
      'z506': instance.updatedAt,
      'z508': instance.updatedBy,
      'ab5': instance.hostFkValue,
      'ab13': instance.reasonFkValue,
      'ab14': instance.reasonValue,
      'ab15': instance.briefReason,
    };
