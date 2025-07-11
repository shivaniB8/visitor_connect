import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/common/blocs/state_events/ui_state.dart';
import 'package:host_visitor_connect/common/data/network/responses/key_value_list_response.dart';
import 'package:host_visitor_connect/common/extensions/future_extensions.dart';
import 'package:host_visitor_connect/features/Filter/data/repos/filter_repository.dart';

class StateFilterBloc extends Cubit<UiState<KeyValueListResponse>> {
  final FilterRepository _filterRepository;

  StateFilterBloc({FilterRepository? filterRepository})
      : _filterRepository = filterRepository ?? FilterRepository(),
        super(Default());

  Future getState() {
    emit(Progress());
    return _filterRepository
        .getStatesFilter()
        .then(_onSuccess)
        .handleError(_onError);
  }

  _onSuccess(KeyValueListResponse keyValueListResponse) async {
    emit(Success(keyValueListResponse));
  }

  _onError(exception) {
    emit(Error(exception as Exception));
  }
}
