import 'package:equatable/equatable.dart';
import 'package:host_visitor_connect/features/invoices/data/network/responses/invoices_list_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'invoices_response.g.dart';

@JsonSerializable(explicitToJson: true)
class InvoicesResponse extends Equatable {
  @JsonKey(name: 'data')
  final InvoicesListResponse? data;

  @JsonKey(name: 'success')
  final bool? success;

  @JsonKey(name: 'message')
  final String? message;

  @JsonKey(name: 'status')
  final int? status;

  const InvoicesResponse({
    this.data,
    this.message,
    this.success,
    this.status,
  });

  factory InvoicesResponse.fromJson(Map<String, dynamic> json) =>
      _$InvoicesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$InvoicesResponseToJson(this);

  @override
  List<Object?> get props => [
        data,
        message,
        success,
        status,
      ];
}
