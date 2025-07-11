import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_error_response.g.dart';

@JsonSerializable(explicitToJson: true)
class OrderErrorResponse extends Equatable {
  @JsonKey(name: 'code')
  final String? code;

  @JsonKey(name: 'description')
  final String? description;

  @JsonKey(name: 'reason')
  final String? reason;

  @JsonKey(name: 'source')
  final String? source;

  @JsonKey(name: 'step')
  final String? step;

  const OrderErrorResponse({
    this.code,
    this.description,
    this.reason,
    this.source,
    this.step,
  });

  factory OrderErrorResponse.fromJson(Map<String, dynamic> json) =>
      _$OrderErrorResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OrderErrorResponseToJson(this);

  @override
  List<Object?> get props => [
        code,
        description,
        reason,
        source,
        step,
      ];
}
