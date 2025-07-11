import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/common/blocs/state_events/ui_state.dart';
import 'package:host_visitor_connect/common/data/network/responses/success_response.dart';
import 'package:host_visitor_connect/common/extensions/future_extensions.dart';
import 'package:host_visitor_connect/features/support_ticket/data/repos/tickets_repository.dart';

class CancelTicketBloc extends Cubit<UiState<SuccessResponse>> {
  final TicketRepository _ticketRepository;

  CancelTicketBloc({TicketRepository? ticketRepository})
      : _ticketRepository = ticketRepository ?? TicketRepository(),
        super(Default());

  Future cancelTicket({
    int? sa1,
    String? sb5,
  }) {
    emit(Progress());
    return _ticketRepository
        .cancelTicket(
          sa1: sa1 ?? 0,
          sb5: sb5 ?? '',
        )
        .then(_onSuccess)
        .handleError(_onError);
  }

  _onSuccess(SuccessResponse successResponse) async {
    emit(Success(successResponse));
  }

  void _onError(exception) {
    emit(Error(exception as Exception));
  }
}
