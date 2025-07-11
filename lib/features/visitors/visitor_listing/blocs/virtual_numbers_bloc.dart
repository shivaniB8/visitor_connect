import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/common/blocs/state_events/ui_state.dart';
import 'package:host_visitor_connect/common/extensions/future_extensions.dart';
import 'package:host_visitor_connect/features/visitors/visitor_listing/data/network/responses/virtual_number_response.dart';
import 'package:host_visitor_connect/features/visitors/visitor_listing/data/repos/visitor_repository.dart';

class VirtualNumbersBloc extends Cubit<UiState<VirtualNumberResponse>> {
  final VisitorRepository _visitorRepository;

  VirtualNumbersBloc({VisitorRepository? visitorRepository})
      : _visitorRepository = visitorRepository ?? VisitorRepository(),
        super(Default());

  void getVirtualNumbers() {
    emit(Progress());
    _visitorRepository
        .getVirtualNumebers()
        .then(_onSuccess)
        .handleError(_onError);
  }

  void _onSuccess(VirtualNumberResponse virtualNumberResponse) {
    emit(Success(virtualNumberResponse));
  }

  _onError(exception) {
    emit(Error(exception));
  }
}
