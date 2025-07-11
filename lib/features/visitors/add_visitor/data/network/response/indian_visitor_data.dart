import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'indian_visitor_data.g.dart';

@JsonSerializable(explicitToJson: true)
class IndianVisitorData extends Equatable {
  @JsonKey(name: 'success')
  final bool? success;

  @JsonKey(name: 'message')
  final String? message;

  @JsonKey(name: 'status')
  final int? status;

  const IndianVisitorData({
    this.message,
    this.success,
    this.status,
  });

  factory IndianVisitorData.fromJson(Map<String, dynamic> json) =>
      _$IndianVisitorDataFromJson(json);

  Map<String, dynamic> toJson() => _$IndianVisitorDataToJson(this);

  @override
  List<Object?> get props => [
        message,
        success,
        status,
      ];
}
