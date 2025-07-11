import 'package:host_visitor_connect/common/data/network/responses/key_value_list_response.dart';
import 'package:host_visitor_connect/common/data/network/responses/page_response.dart';
import 'package:host_visitor_connect/common/data/network/responses/success_response.dart';
import 'package:host_visitor_connect/features/support_ticket/data/network/api_services/tickets_api_service.dart';
import 'package:host_visitor_connect/features/support_ticket/data/network/responses/module_response.dart';
import 'package:host_visitor_connect/features/support_ticket/data/network/responses/ticket_history_response.dart';
import 'package:host_visitor_connect/features/support_ticket/data/network/responses/ticket_response.dart';
import 'package:image_picker/image_picker.dart';

class TicketRepository {
  final TicketApiService _ticketApiService;

  TicketRepository({TicketApiService? ticketApiService})
      : _ticketApiService = ticketApiService ?? TicketApiService();

  Future<PageResponse<TicketResponse>> getTickets({
    required int status,
    int? pageNo,
    int? sa5,
    String? submittedFrom,
    String? submittedTill,
    String? tentativeDateFrom,
    String? tentativeDateTill,
    String? closedDateFrom,
    String? closedDateTill,
    String? cancelledDateFrom,
    String? cancelledDateTill,
    int? ticketNumber,
  }) {
    return _ticketApiService.getTickets(
      status: status,
      pageNo: pageNo,
      sa5: sa5,
      ticketNumber: ticketNumber,
      submittedFrom: submittedFrom,
      submittedTill: submittedTill,
      tentativeDateFrom: tentativeDateFrom,
      tentativeDateTill: tentativeDateTill,
      cancelledDateFrom: cancelledDateFrom,
      cancelledDateTill: cancelledDateTill,
      closedDateFrom: closedDateFrom,
      closedDateTill: closedDateTill,
    );
  }

  Future<TicketHistoryResponse> getTicketsHistory({
    required int sa1,
  }) {
    return _ticketApiService.ticketHistory(
      sa1: sa1,
    );
  }

  Future<KeyValueListResponse> getActiveUsers({
    int? isMobile,
  }) {
    return _ticketApiService.getUsersList(
      isMobile: isMobile,
    );
  }

  Future<ModuleResponse> getModules() {
    return _ticketApiService.getModules();
  }

  Future<SuccessResponse> createTicket({
    required Map<String, dynamic> createTicketMap,
    XFile? screenshot1,
    XFile? screenshot2,
    XFile? screenshot3,
    XFile? screenshot4,
    XFile? screenshot5,
  }) {
    return _ticketApiService.createTicket(
      createTicketMap: createTicketMap,
      screenshot1: screenshot1,
      screenshot2: screenshot2,
      screenshot3: screenshot3,
      screenshot4: screenshot4,
      screenshot5: screenshot5,
    );
  }

  Future<SuccessResponse> cancelTicket({
    required String sb5,
    required int sa1,
  }) {
    return _ticketApiService.cancelTicket(
      sb5: sb5,
      sa1: sa1,
    );
  }

  Future<SuccessResponse> ticketCommunication({
    String? sb5,
    required int sa1,
    XFile? screenshot1,
    XFile? screenshot2,
    XFile? screenshot3,
    XFile? screenshot4,
    XFile? screenshot5,
  }) {
    return _ticketApiService.ticketCommunication(
      sb5: sb5,
      sa1: sa1,
      screenshot1: screenshot1,
      screenshot2: screenshot2,
      screenshot3: screenshot3,
      screenshot4: screenshot4,
      screenshot5: screenshot5,
    );
  }
}
