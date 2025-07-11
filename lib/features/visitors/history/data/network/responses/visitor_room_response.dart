import 'package:equatable/equatable.dart';
import 'package:host_visitor_connect/features/visitors/visitor_listing/data/network/responses/visitor_details_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'visitor_room_response.g.dart';

@JsonSerializable(explicitToJson: true)
class VisitorRoomResponse extends Equatable {
  @JsonKey(name: 'ab10')
  final String? roomNo;

  @JsonKey(name: 'date')
  final String? date;

  @JsonKey(name: 'visitors')
  final List<VisitorDetailsResponse>? visitors;

  const VisitorRoomResponse({
    this.roomNo,
    this.date,
    this.visitors,
  });

  factory VisitorRoomResponse.fromJson(Map<String, dynamic> json) {
    return _$VisitorRoomResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$VisitorRoomResponseToJson(this);

  @override
  List<Object?> get props => [
        roomNo,
        date,
        visitors,
      ];
}
