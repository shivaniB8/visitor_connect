import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/common/blocs/state_events/ui_state.dart';
import 'package:host_visitor_connect/common/extensions/future_extensions.dart';
import 'package:host_visitor_connect/features/visitors/visitor_listing/data/network/responses/outgoing_call_response.dart';
import 'package:host_visitor_connect/features/visitors/visitor_listing/data/repos/visitor_repository.dart';

class OutgoingCallBloc extends Cubit<UiState<OutgoingCallResponse>> {
  final VisitorRepository _visitorRepository;

  OutgoingCallBloc({VisitorRepository? visitorRepository})
      : _visitorRepository = visitorRepository ?? VisitorRepository(),
        super(Default());

  Future outgoingCall({
    required int visitorId,
    required int settingId,
  }) {
    emit(Progress());
    return _visitorRepository
        .outgoingCall(
          settingId: settingId,
          visitorId: visitorId,
        )
        .then(_onSuccess)
        .handleError(_onError);
  }

  void _onSuccess(OutgoingCallResponse outgoingCallResponse) {
    emit(Success(outgoingCallResponse));
  }

  _onError(exception) {
    emit(Error(exception));
  }
}
