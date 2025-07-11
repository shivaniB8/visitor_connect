import 'package:equatable/equatable.dart';
import 'package:host_visitor_connect/features/payment_pateways/razorpay/data/responses/razor_pay_order_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'razor_pay_order_response_data.g.dart';

@JsonSerializable(explicitToJson: true)
class RazorPayOrderResponseData extends Equatable {
  @JsonKey(name: 'success')
  final bool? success;

  @JsonKey(name: 'status')
  final int? status;

  @JsonKey(name: 'message')
  final String? message;

  @JsonKey(name: 'record')
  final RazorPayOrderResponse? records;

  const RazorPayOrderResponseData({
    this.success,
    this.message,
    this.records,
    this.status,
  });

  factory RazorPayOrderResponseData.fromJson(Map<String, dynamic> json) =>
      _$RazorPayOrderResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$RazorPayOrderResponseDataToJson(this);

  @override
  List<Object?> get props => [
        success,
        message,
        records,
        status,
      ];
}
