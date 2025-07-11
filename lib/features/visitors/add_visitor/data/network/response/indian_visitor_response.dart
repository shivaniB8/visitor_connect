import 'package:equatable/equatable.dart';
import 'package:host_visitor_connect/features/visitors/add_visitor/data/network/response/indian_visitor_data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'indian_visitor_response.g.dart';

@JsonSerializable(explicitToJson: true)
class IndianVisitorResponse extends Equatable {
  @JsonKey(name: 'data')
  final IndianVisitorData? data;

  @JsonKey(name: 'success')
  final bool? success;

  @JsonKey(name: 'message')
  final String? message;

  @JsonKey(name: 'status')
  final int? status;

  const IndianVisitorResponse({
    this.data,
    this.message,
    this.success,
    this.status,
  });

  factory IndianVisitorResponse.fromJson(Map<String, dynamic> json) =>
      _$IndianVisitorResponseFromJson(json);

  Map<String, dynamic> toJson() => _$IndianVisitorResponseToJson(this);

  @override
  List<Object?> get props => [
        data,
        message,
        success,
        status,
      ];
}
