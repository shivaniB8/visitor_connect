import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/common/blocs/state_events/ui_state.dart';
import 'package:host_visitor_connect/common/extensions/future_extensions.dart';
import 'package:host_visitor_connect/common/data/network/responses/key_value_list_response.dart';

import 'package:host_visitor_connect/features/report/report_list/data/repos/report_visitor_repository.dart';

class ReportReasonsBloc extends Cubit<UiState<KeyValueListResponse>> {
  final ReportVisitorRepository _reportVisitorRepository;

  ReportReasonsBloc({ReportVisitorRepository? reportVisitorRepository})
      : _reportVisitorRepository =
            reportVisitorRepository ?? ReportVisitorRepository(),
        super(Default());

  Future getReasonsList() {
    emit(Progress());
    return _reportVisitorRepository
        .getReasonsList()
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
