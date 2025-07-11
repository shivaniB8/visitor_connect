import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/common/blocs/state_events/ui_state.dart';
import 'package:host_visitor_connect/common/data/network/responses/page_response.dart';
import 'package:host_visitor_connect/common/extensions/future_extensions.dart';
import 'package:host_visitor_connect/common/utils/app_function.dart';
import 'package:host_visitor_connect/features/support_ticket/data/network/responses/ticket_response.dart';
import 'package:host_visitor_connect/features/support_ticket/data/repos/tickets_repository.dart';
import 'package:host_visitor_connect/features/support_ticket/model/ticket.dart';

class ClosedTicketBloc extends Cubit<UiState<List<Ticket>>> {
  PageResponse<TicketResponse>? _currentPageResponse;
  final TicketRepository _ticketRepository;
  List<Ticket> tickets = [];
  late Completer refreshCompleter;
  bool isfilterApplied = false;

  ClosedTicketBloc({
    TicketRepository? ticketRepository,
  })  : _ticketRepository = ticketRepository ?? TicketRepository(),
        super(Default());

  Future getTickets({
    int pageNo = 0,
    required int status,
    bool isRefreshingList = false,
    int? sa5,
    String? submittedFrom,
    String? submittedTill,
    String? closedDateFrom,
    String? closedDateTill,

    // FiltersModel? filters,
  }) async {
    emit(Progress());

    if (pageNo == 0 || isRefreshingList) {
      tickets.clear();
    }
    if (isRefreshingList) {
      refreshCompleter = Completer();
    }
    return _ticketRepository
        .getTickets(
          status: 3,
          sa5: sa5,
          submittedFrom: submittedFrom,
          submittedTill: submittedTill,
          closedDateFrom: closedDateFrom,
          closedDateTill: closedDateTill,
          pageNo: pageNo,
        )
        .then(_onSuccess)
        .handleError(_onError)
        .whenComplete(
      () {
        if (isRefreshingList) {
          refreshCompleter.complete();
        }
      },
    );
  }

  void _onSuccess(PageResponse<TicketResponse>? pageResponse) {
    if (pageResponse?.sessionExpired == 1) {
      AppFunctions.unAuthorizedEntry(true);
    }
    pageResponse?.content?.forEach((ticketResponse) {
      tickets.add(Ticket.fromApiResponse(ticketResponse));
    });
    _currentPageResponse = pageResponse;
    emit(Success(tickets));
  }

  void _onError(exception) {
    emit(Error(exception as Exception));
  }

  void getNextPageOfTickets({
    // FiltersModel? filters,
    int? status,
  }) {
    if (canLoadMorePages()) {
      getTickets(
        status: status ?? 0,

        // filters: filters,
        pageNo: (_currentPageResponse?.pageNo ?? 0) + 1,
      );
    }
  }

  bool canLoadMorePages() {
    return state is! Progress && !(_currentPageResponse?.isLast ?? false);
  }

  void refreshTickets({
    bool isRefreshingList = false,
    required int status,
  }) {
    tickets.clear();
    getTickets(
      isRefreshingList: isRefreshingList,
      status: status,
    );
  }
}
