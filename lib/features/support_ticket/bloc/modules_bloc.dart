import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/common/blocs/state_events/ui_state.dart';
import 'package:host_visitor_connect/common/extensions/future_extensions.dart';
import 'package:host_visitor_connect/features/support_ticket/data/network/responses/module_response.dart';
import 'package:host_visitor_connect/features/support_ticket/data/repos/tickets_repository.dart';

class ModulesBloc extends Cubit<UiState<ModuleResponse>> {
  final TicketRepository _ticketRepository;

  ModulesBloc({TicketRepository? ticketRepository})
      : _ticketRepository = ticketRepository ?? TicketRepository(),
        super(Default());

  Future getModules() {
    emit(Progress());
    return _ticketRepository
        .getModules()
        .then(_onSuccess)
        .handleError(_onError);
  }

  _onSuccess(ModuleResponse moduleResponse) async {
    emit(Success(moduleResponse));
  }

  clearState() {
    emit(Default());
  }

  void _onError(exception) {
    emit(Error(exception as Exception));
  }
}
