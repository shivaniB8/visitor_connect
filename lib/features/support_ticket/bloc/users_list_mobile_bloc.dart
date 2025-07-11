import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/common/blocs/state_events/ui_state.dart';
import 'package:host_visitor_connect/common/data/network/responses/key_value_list_response.dart';
import 'package:host_visitor_connect/common/extensions/future_extensions.dart';
import 'package:host_visitor_connect/features/support_ticket/data/repos/tickets_repository.dart';

class UsersListMobileBloc extends Cubit<UiState<KeyValueListResponse>> {
  final TicketRepository _ticketRepository;

  UsersListMobileBloc({TicketRepository? ticketRepository})
      : _ticketRepository = ticketRepository ?? TicketRepository(),
        super(Default());

  Future getUsersMobileList() {
    emit(Progress());
    return _ticketRepository
        .getActiveUsers(
          isMobile: 1,
        )
        .then(_onSuccess)
        .handleError(_onError);
  }

  _onSuccess(KeyValueListResponse keyValueListResponse) async {
    emit(Success(keyValueListResponse));
  }

  clearState() {
    emit(Default());
  }

  void _onError(exception) {
    emit(Error(exception as Exception));
  }
}
