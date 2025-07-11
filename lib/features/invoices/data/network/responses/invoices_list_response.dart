import 'package:equatable/equatable.dart';
import 'package:host_visitor_connect/features/invoices/data/network/responses/invoice_data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'invoices_list_response.g.dart';

@JsonSerializable(explicitToJson: true)
class InvoicesListResponse extends Equatable {
  @JsonKey(name: 'January')
  final List<InvoiceData>? janData;

  @JsonKey(name: 'February')
  final List<InvoiceData>? febData;

  @JsonKey(name: 'March')
  final List<InvoiceData>? marchData;

  @JsonKey(name: 'April')
  final List<InvoiceData>? aprilData;

  @JsonKey(name: 'May')
  final List<InvoiceData>? mayData;

  @JsonKey(name: 'June')
  final List<InvoiceData>? juneData;

  @JsonKey(name: 'July')
  final List<InvoiceData>? julyData;

  @JsonKey(name: 'August')
  final List<InvoiceData>? augData;

  @JsonKey(name: 'September')
  final List<InvoiceData>? septData;

  @JsonKey(name: 'October')
  final List<InvoiceData>? octData;

  @JsonKey(name: 'November')
  final List<InvoiceData>? novData;

  @JsonKey(name: 'December')
  final List<InvoiceData>? decData;

  const InvoicesListResponse({
    this.janData,
    this.febData,
    this.marchData,
    this.aprilData,
    this.mayData,
    this.juneData,
    this.julyData,
    this.augData,
    this.septData,
    this.octData,
    this.novData,
    this.decData,
  });

  factory InvoicesListResponse.fromJson(Map<String, dynamic> json) =>
      _$InvoicesListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$InvoicesListResponseToJson(this);

  @override
  List<Object?> get props => [
        janData,
        febData,
        marchData,
        aprilData,
        mayData,
        juneData,
        julyData,
        augData,
        septData,
        octData,
        novData,
        decData,
      ];
}
