import 'package:equatable/equatable.dart';
import 'package:host_visitor_connect/features/payment_pateways/razorpay/data/responses/razor_pay_order_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'razor_pay_transaction_response.g.dart';

@JsonSerializable(explicitToJson: true)
class RazorPayTransactionResponse extends Equatable {
  @JsonKey(name: 'status')
  final int? status;

  @JsonKey(name: 'message')
  final String? message;

  @JsonKey(name: 'response')
  final RazorPayOrderResponse? records;

  const RazorPayTransactionResponse({
    this.message,
    this.records,
    this.status,
  });

  factory RazorPayTransactionResponse.fromJson(Map<String, dynamic> json) =>
      _$RazorPayTransactionResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RazorPayTransactionResponseToJson(this);

  @override
  List<Object?> get props => [
        message,
        records,
        status,
      ];
}
