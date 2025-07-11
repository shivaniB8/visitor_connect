import 'package:equatable/equatable.dart';
import 'package:host_visitor_connect/features/support_ticket/data/network/responses/ticket_response.dart';

class Ticket extends Equatable {
  final int? id;
  final int? ticketNumber;
  final int? problemIn;
  final int? chargeType;
  final int? ticketType;
  final String? ticketCancelledByFk;
  final String? ticketCancelledByValue;
  final int? paidTicketStatementFk;
  final int? chargeReverseStatementFk;
  final String? ticketCreatedAt;
  final String? ticketOpenedAt;
  final int? ticketOpenedByTicketFk;
  final String? ticketOpenedByTicketValue;
  final String? ticketOwnerEmployeeFk;
  final String? ticketOwnerEmployeeValue;
  final int? ticketStatus;
  final int? ticketFeedbakcStatus;
  final int? callinPin;
  final int? thirdPartyDependency;
  final String? tentativeClosingDate;
  final String? remainingTimeToClose;
  final String? ticketWorkingTime;
  final String? ticketCreatedByEmployeeFk;
  final String? ticketCreatedByEmployeeValue;
  final String? ticketClosedTime;
  final int? ticketClosedEmployeeFk;
  final String? ticketClosedEmployeeFkValue;
  final String? effectedModule;
  final int? paidTicketTaxStatementFk;
  final int? hostFk;

  final String? createdAt;
  final int? createdBy;
  final String? createdByName;
  final String? updatedAt;
  final int? updatedByFk;
  final String? updatedByValue;

  const Ticket({
    this.id,
    this.thirdPartyDependency,
    this.ticketNumber,
    this.problemIn,
    this.chargeType,
    this.ticketType,
    this.ticketCancelledByFk,
    this.ticketCancelledByValue,
    this.paidTicketStatementFk,
    this.chargeReverseStatementFk,
    this.ticketCreatedAt,
    this.tentativeClosingDate,
    this.ticketOpenedAt,
    this.ticketOpenedByTicketFk,
    this.ticketOpenedByTicketValue,
    this.ticketOwnerEmployeeFk,
    this.ticketOwnerEmployeeValue,
    this.ticketStatus,
    this.ticketFeedbakcStatus,
    this.callinPin,
    this.remainingTimeToClose,
    this.ticketWorkingTime,
    this.ticketCreatedByEmployeeFk,
    this.ticketCreatedByEmployeeValue,
    this.ticketClosedTime,
    this.ticketClosedEmployeeFk,
    this.ticketClosedEmployeeFkValue,
    this.effectedModule,
    this.paidTicketTaxStatementFk,
    this.hostFk,
    this.createdAt,
    this.createdBy,
    this.createdByName,
    this.updatedAt,
    this.updatedByFk,
    this.updatedByValue,
  });

  factory Ticket.fromApiResponse(
    TicketResponse ticketResponse,
  ) {
    return Ticket(
      id: ticketResponse.sa1,
      ticketNumber: ticketResponse.sa4,
      problemIn: ticketResponse.sa5,
      chargeType: ticketResponse.sa7,
      tentativeClosingDate: ticketResponse.sa41,
      ticketCancelledByFk: ticketResponse.sa8,
      ticketCancelledByValue: ticketResponse.sa9,
      paidTicketStatementFk: ticketResponse.sa10,
      chargeReverseStatementFk: ticketResponse.sa11,
      ticketCreatedAt: ticketResponse.sa12,
      ticketOpenedAt: ticketResponse.sa13,
      remainingTimeToClose: ticketResponse.sa28,
      thirdPartyDependency: ticketResponse.sa26,
      ticketOpenedByTicketFk: ticketResponse.sa14,
      ticketOpenedByTicketValue: ticketResponse.sa15,
      ticketOwnerEmployeeFk: ticketResponse.sa16,
      ticketStatus: ticketResponse.sa18,
      ticketOwnerEmployeeValue: ticketResponse.sa17,
      callinPin: ticketResponse.sa27,
      ticketCreatedByEmployeeFk: ticketResponse.sa30,
      ticketCreatedByEmployeeValue: ticketResponse.sa31,
      ticketClosedTime: ticketResponse.sa32,
      effectedModule: ticketResponse.sa35,
      hostFk: ticketResponse.sa37,
      createdAt: ticketResponse.z501,
      createdBy: ticketResponse.z502,
      createdByName: ticketResponse.z503,
      updatedAt: ticketResponse.z506,
      updatedByFk: ticketResponse.z507,
      updatedByValue: ticketResponse.z508,
    );
  }

  @override
  List<Object?> get props => [
        id,
        ticketNumber,
        problemIn,
        chargeType,
        ticketType,
        ticketCancelledByFk,
        ticketCancelledByValue,
        paidTicketStatementFk,
        chargeReverseStatementFk,
        tentativeClosingDate,
        ticketCreatedAt,
        ticketOpenedAt,
        ticketOpenedByTicketFk,
        ticketOpenedByTicketValue,
        ticketOwnerEmployeeFk,
        ticketOwnerEmployeeValue,
        ticketStatus,
        ticketFeedbakcStatus,
        callinPin,
        thirdPartyDependency,
        remainingTimeToClose,
        ticketWorkingTime,
        ticketCreatedByEmployeeFk,
        ticketCreatedByEmployeeValue,
        ticketClosedTime,
        ticketClosedEmployeeFk,
        ticketClosedEmployeeFkValue,
        effectedModule,
        paidTicketTaxStatementFk,
        hostFk,
        createdAt,
        createdBy,
        createdByName,
        updatedAt,
        updatedByFk,
        updatedByValue,
      ];
}
