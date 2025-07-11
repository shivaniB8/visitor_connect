import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'razor_pay_transaction_data.g.dart';

@JsonSerializable(explicitToJson: true)
class RazorPayTransactionData extends Equatable {
  @JsonKey(name: 'he1')
  final int? id;

  @JsonKey(name: 'he2')
  final int? clientId;

  @JsonKey(name: 'he3')
  final String? client;

  @JsonKey(name: 'he7')
  final int? amountPaid;

  @JsonKey(name: 'he8')
  final String? paymentMode;

  @JsonKey(name: 'he9')
  final String? transactionId;

  @JsonKey(name: 'he10')
  final String? orderId;

  @JsonKey(name: 'he12')
  final String? paymentSubMode;

  const RazorPayTransactionData({
    this.id,
    this.clientId,
    this.client,
    this.amountPaid,
    this.paymentMode,
    this.transactionId,
    this.orderId,
    this.paymentSubMode,
  });

  factory RazorPayTransactionData.fromJson(Map<String, dynamic> json) =>
      _$RazorPayTransactionDataFromJson(json);

  Map<String, dynamic> toJson() => _$RazorPayTransactionDataToJson(this);

  @override
  List<Object?> get props => [
        id,
        clientId,
        client,
        amountPaid,
        paymentMode,
        transactionId,
        orderId,
        paymentSubMode,
      ];
}
