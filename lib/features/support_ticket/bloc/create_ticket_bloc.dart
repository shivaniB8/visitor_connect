import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/common/blocs/state_events/ui_state.dart';
import 'package:host_visitor_connect/common/data/network/responses/success_response.dart';
import 'package:host_visitor_connect/common/extensions/future_extensions.dart';
import 'package:host_visitor_connect/features/support_ticket/data/repos/tickets_repository.dart';
import 'package:image_picker/image_picker.dart';

class CreateTicketBloc extends Cubit<UiState<SuccessResponse>> {
  final TicketRepository _ticketRepository;

  CreateTicketBloc({TicketRepository? ticketRepository})
      : _ticketRepository = ticketRepository ?? TicketRepository(),
        super(Default());

  Future createTicket({
    required Map<String, dynamic> ticketMap,
    XFile? screenshot1,
    XFile? screenshot2,
    XFile? screenshot3,
    XFile? screenshot4,
    XFile? screenshot5,
  }) {
    emit(Progress());
    return _ticketRepository
        .createTicket(
          createTicketMap: ticketMap,
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
