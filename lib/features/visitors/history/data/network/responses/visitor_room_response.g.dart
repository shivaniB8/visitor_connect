// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'visitor_room_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VisitorRoomResponse _$VisitorRoomResponseFromJson(Map<String, dynamic> json) =>
    VisitorRoomResponse(
      roomNo: json['ab10'] as String?,
      date: json['date'] as String?,
      visitors: (json['visitors'] as List<dynamic>?)
          ?.map(
              (e) => VisitorDetailsResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$VisitorRoomResponseToJson(
        VisitorRoomResponse instance) =>
    <String, dynamic>{
      'ab10': instance.roomNo,
      'date': instance.date,
      'visitors': instance.visitors?.map((e) => e.toJson()).toList(),
    };
