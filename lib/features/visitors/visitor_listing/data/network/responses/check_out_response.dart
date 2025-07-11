import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'check_out_response.g.dart';

@JsonSerializable(explicitToJson: true)
class CheckOutResponse extends Equatable {
  @JsonKey(name: 'success')
  final bool? success;

  @JsonKey(name: 'status')
  final int? status;

  @JsonKey(name: 'message')
  final String? message;

  const CheckOutResponse({
    this.success,
    this.status,
    this.message,
  });

  factory CheckOutResponse.fromJson(Map<String, dynamic> json) =>
      _$CheckOutResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CheckOutResponseToJson(this);

  @override
  List<Object?> get props => [
        success,
        status,
        message,
      ];
}
