import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'invoice_data.g.dart';

@JsonSerializable(explicitToJson: true)
class InvoiceData extends Equatable {
  @JsonKey(name: 'hb1')
  final String? id;

  @JsonKey(name: 'hb2')
  final int? clientFk;

  @JsonKey(name: 'hb3')
  final String? clientFkValue;

  @JsonKey(name: 'hb6')
  final String? invoiceDate;

  @JsonKey(name: 'hb7')
  final double? amountBeforeTax;

  @JsonKey(name: 'hb8')
  final double? taxAmount;

  @JsonKey(name: 'hb9')
  final double? totalAmount;

  @JsonKey(name: 'hb10')
  final String? fileName;

  @JsonKey(name: 'hb11')
  final String? fileLink;


  @JsonKey(name: 'hb15')
  final int? billMonth;

  @JsonKey(name: 'hb16')
  final int? billYear;

  @JsonKey(name: 'hb18')
  final int? hostFk;

  const InvoiceData({
    this.id,
    this.clientFk,
    this.clientFkValue,
    this.invoiceDate,
    this.amountBeforeTax,
    this.taxAmount,
    this.totalAmount,
    this.fileName,
    this.fileLink,
    this.billMonth,
    this.billYear,
    this.hostFk,
  });

  factory InvoiceData.fromJson(Map<String, dynamic> json) =>
      _$InvoiceDataFromJson(json);

  Map<String, dynamic> toJson() => _$InvoiceDataToJson(this);

  @override
  List<Object?> get props => [
        id,
        clientFk,
        clientFkValue,
        invoiceDate,
        amountBeforeTax,
        taxAmount,
        totalAmount,
        fileName,
        fileLink,
        billMonth,
        billYear,
        hostFk
      ];
}
