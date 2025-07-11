import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/common/blocs/state_events/ui_state.dart';
import 'package:host_visitor_connect/common/extensions/future_extensions.dart';
import 'package:host_visitor_connect/common/data/network/responses/key_value_list_response.dart';
import 'package:host_visitor_connect/features/visitors/add_visitor/data/repos/add_visitor_repository.dart';

class ReasonToVisitBloc extends Cubit<UiState<KeyValueListResponse>> {
  final AddVisitorRepository _addVisitorRepository;

  ReasonToVisitBloc({AddVisitorRepository? addVisitorRepository})
      : _addVisitorRepository = addVisitorRepository ?? AddVisitorRepository(),
        super(Default());

  Future getReasonToVisit() {
    emit(Progress());
    return _addVisitorRepository
        .getReasonToVisit()
        .then(_onSuccess)
        .handleError(_onError);
  }

  _onSuccess(KeyValueListResponse keyValueListResponse) async {
    emit(Success(keyValueListResponse));
  }

  void _onError(exception) {
    emit(Error(exception as Exception));
  }
}
