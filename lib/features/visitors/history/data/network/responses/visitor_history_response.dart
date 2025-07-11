import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'visitor_history_response.g.dart';

@JsonSerializable(explicitToJson: true)
class VisitorHistoryResponse extends Equatable {
  @JsonKey(name: 'ab1')
  final int? id;

  @JsonKey(name: 'ab2')
  final int? visitorFk;

  @JsonKey(name: 'ab3')
  final String? visitorFkValue;

  @JsonKey(name: 'ab4')
  final int? hostFk;

  @JsonKey(name: 'ab6')
  final String? entryDateTime;

  @JsonKey(name: 'ab7')
  final String? exitDateTime;

  @JsonKey(name: 'ab8')
  final int? branchFk;

  @JsonKey(name: 'ab9')
  final String? branchValue;

  @JsonKey(name: 'z506')
  final String? updatedAt;

  @JsonKey(name: 'z508')
  final String? updatedBy;

  @JsonKey(name: 'ab5')
  final String? hostFkValue;

  @JsonKey(name: 'ab13')
  final int? reasonFkValue;

  @JsonKey(name: 'ab14')
  final String? reasonValue;
  @JsonKey(name: 'ab15')
  final String? briefReason;

  const VisitorHistoryResponse(
      {this.id,
      this.visitorFk,
      this.hostFk,
      this.entryDateTime,
      this.exitDateTime,
      this.branchFk,
      this.branchValue,
      this.updatedAt,
      this.visitorFkValue,
      this.updatedBy,
      this.hostFkValue,
      this.reasonFkValue,
      this.reasonValue,
      this.briefReason});

  factory VisitorHistoryResponse.fromJson(Map<String, dynamic> json) =>
      _$VisitorHistoryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$VisitorHistoryResponseToJson(this);

  @override
  List<Object?> get props => [
        id,
        visitorFk,
        hostFk,
        entryDateTime,
        exitDateTime,
        branchFk,
        branchValue,
        updatedAt,
        visitorFkValue,
        updatedBy,
        hostFkValue,
        reasonValue,
        reasonFkValue,
        briefReason
      ];
}
