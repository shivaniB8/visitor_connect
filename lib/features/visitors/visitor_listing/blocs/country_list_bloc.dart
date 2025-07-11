import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/common/blocs/state_events/ui_state.dart';
import 'package:host_visitor_connect/common/extensions/future_extensions.dart';
import 'package:host_visitor_connect/common/data/network/responses/key_value_list_response.dart';
import 'package:host_visitor_connect/features/visitors/visitor_listing/data/repos/visitor_repository.dart';

class CountryListBloc extends Cubit<UiState<KeyValueListResponse>> {
  final VisitorRepository _visitorRepository;

  CountryListBloc({VisitorRepository? visitorRepository})
      : _visitorRepository = visitorRepository ?? VisitorRepository(),
        super(Default());

  void getCountryList() {
    emit(Progress());
    _visitorRepository.getCountryList().then(_onSuccess).handleError(_onError);
  }

  _onSuccess(KeyValueListResponse keyValueListResponse) async {
    emit(Success(keyValueListResponse));
  }

  void _onError(exception) {
    emit(Error(exception as Exception));
  }
}
