import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/common/blocs/state_events/ui_state.dart';
import 'package:host_visitor_connect/common/data/network/responses/success_response.dart';
import 'package:host_visitor_connect/common/extensions/future_extensions.dart';
import 'package:host_visitor_connect/features/support_ticket/data/repos/tickets_repository.dart';
import 'package:image_picker/image_picker.dart';

class TicketCommunicationBloc extends Cubit<UiState<SuccessResponse>> {
  final TicketRepository _ticketRepository;

  TicketCommunicationBloc({TicketRepository? ticketRepository})
      : _ticketRepository = ticketRepository ?? TicketRepository(),
        super(Default());

  Future ticketCommunication({
    int? sa1,
    String? sb5,
    XFile? screenshot1,
    XFile? screenshot2,
    XFile? screenshot3,
    XFile? screenshot4,
    XFile? screenshot5,
  }) {
    emit(Progress());
    return _ticketRepository
        .ticketCommunication(
          sa1: sa1 ?? 0,
          sb5: sb5 ?? '',
          screenshot5: screenshot5,
          screenshot4: screenshot4,
          screenshot3: screenshot3,
          screenshot2: screenshot2,
          screenshot1: screenshot1,
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
