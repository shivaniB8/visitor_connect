import 'package:equatable/equatable.dart';
import 'package:host_visitor_connect/features/payment_pateways/razorpay/data/responses/order_error_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'razor_pay_order_response.g.dart';

@JsonSerializable(explicitToJson: true)
class RazorPayOrderResponse extends Equatable {
  @JsonKey(name: 'amount')
  final int? amount;

  @JsonKey(name: 'amount_due')
  final int? amountDue;

  @JsonKey(name: 'amount_paid')
  final int? amountPaid;

  @JsonKey(name: 'attempts')
  final int? attempts;

  @JsonKey(name: 'created_at')
  final int? createdAt;

  @JsonKey(name: 'currency')
  final String? currency;

  @JsonKey(name: 'entity')
  final String? entity;

  @JsonKey(name: 'id')
  final String? orderId;

  @JsonKey(name: 'status')
  final String? status;

  @JsonKey(name: 'error')
  final OrderErrorResponse? error;

  const RazorPayOrderResponse({
    this.amount,
    this.amountDue,
    this.amountPaid,
    this.attempts,
    this.createdAt,
    this.currency,
    this.entity,
    this.orderId,
    this.status,
    this.error,
  });

  factory RazorPayOrderResponse.fromJson(Map<String, dynamic> json) =>
      _$RazorPayOrderResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RazorPayOrderResponseToJson(this);

  @override
  List<Object?> get props => [
        amount,
        amountDue,
        amountPaid,
        attempts,
        createdAt,
        currency,
        entity,
        orderId,
        status,
        error,
      ];
}
