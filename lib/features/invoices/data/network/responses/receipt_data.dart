import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'receipt_data.g.dart';

@JsonSerializable(explicitToJson: true)
class ReceiptData extends Equatable {
  @JsonKey(name: 'hc1')
  final String? id;

  @JsonKey(name: 'hc2')
  final int? clientFk;

  @JsonKey(name: 'hc3')
  final String? clientFkValue;

  @JsonKey(name: 'hc4')
  final int? razorPayCheckoutFK;

  @JsonKey(name: 'hc5')
  final String? receiptDate;

  @JsonKey(name: 'hc6')
  final String? paymentDate;

  /// 1. Payment Gateway, 2. Cheque, 3. NEFT / RTGS, 4. IMPS, 5= Advance Credit
  @JsonKey(name: 'hc7')
  final int? paymentMode;

  @JsonKey(name: 'hc8')
  final String? paymentId;

  @JsonKey(name: 'hc9')
  final String? signature;

  @JsonKey(name: 'hc10')
  final String? paymentDetails;

  @JsonKey(name: 'hc15')
  final String? paymentReceiptName;

  @JsonKey(name: 'hc16')
  final String? paymentReceiptUrl;

  @JsonKey(name: 'hc18')
  final String? paymentOrderId;

  @JsonKey(name: 'hc21')
  final int? paymentInWords;

  const ReceiptData(this.paymentReceiptUrl,
      {this.id,
      this.clientFk,
      this.clientFkValue,
      this.paymentDate,
      this.paymentDetails,
      this.paymentId,
      this.paymentInWords,
      this.paymentMode,
      this.paymentOrderId,
      this.paymentReceiptName,
      this.razorPayCheckoutFK,
      this.receiptDate,
      this.signature});

  factory ReceiptData.fromJson(Map<String, dynamic> json) =>
      _$ReceiptDataFromJson(json);

  Map<String, dynamic> toJson() => _$ReceiptDataToJson(this);

  @override
  List<Object?> get props => [
        id,
        clientFk,
        clientFkValue,
        paymentDate,
        paymentDetails,
        paymentId,
        paymentInWords,
        paymentMode,
        paymentOrderId,
        paymentReceiptName,
        razorPayCheckoutFK,
        receiptDate,
        signature
      ];
}
