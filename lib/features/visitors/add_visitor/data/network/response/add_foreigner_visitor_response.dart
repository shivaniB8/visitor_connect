import 'package:equatable/equatable.dart';
import 'package:host_visitor_connect/features/visitors/add_visitor/data/network/response/foreigner_data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'add_foreigner_visitor_response.g.dart';

@JsonSerializable(explicitToJson: true)
class AddForeignerVisitorResponse extends Equatable {
  @JsonKey(name: 'success')
  final bool? success;

  @JsonKey(name: 'status')
  final int? statusCode;

  @JsonKey(name: 'message')
  final String? message;

  @JsonKey(name: 'data')
  final ForeignerData? foreignerData;

  const AddForeignerVisitorResponse({
    this.success,
    this.statusCode,
    this.message,
    this.foreignerData,
  });

  factory AddForeignerVisitorResponse.fromJson(Map<String, dynamic> json) =>
      _$AddForeignerVisitorResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AddForeignerVisitorResponseToJson(this);

  @override
  List<Object?> get props => [
        success,
        statusCode,
        message,
        foreignerData,
      ];
}
