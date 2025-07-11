import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/common/blocs/state_events/ui_state.dart';
import 'package:host_visitor_connect/common/extensions/future_extensions.dart';
import 'package:host_visitor_connect/features/support_ticket/data/repos/tickets_repository.dart';

import '../data/network/responses/ticket_history_response.dart';

class TicketHistoryBloc extends Cubit<UiState<TicketHistoryResponse>> {
  final TicketRepository _ticketRepository;

  TicketHistoryBloc({TicketRepository? ticketRepository})
      : _ticketRepository = ticketRepository ?? TicketRepository(),
        super(Default());

  Future getTicketHistory({
    required int sa1,
  }) {
    emit(Progress());
    return _ticketRepository
        .getTicketsHistory(
          sa1: sa1,
        )
        .then(_onSuccess)
        .handleError(_onError);
  }

  _onSuccess(TicketHistoryResponse ticketHistoryResponse) async {
    emit(Success(ticketHistoryResponse));
  }

  clearState() {
    emit(Default());
  }

  void _onError(exception) {
    emit(Error(exception as Exception));
  }
}
