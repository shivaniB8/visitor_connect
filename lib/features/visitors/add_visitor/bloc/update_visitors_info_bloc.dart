import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/common/blocs/state_events/ui_state.dart';
import 'package:host_visitor_connect/common/data/network/responses/success_response.dart';
import 'package:host_visitor_connect/common/extensions/future_extensions.dart';
import 'package:host_visitor_connect/features/visitors/add_visitor/data/repos/add_visitor_repository.dart';

class UpdateVisitorInfoBloc extends Cubit<UiState<SuccessResponse>> {
  final AddVisitorRepository _addVisitorRepository;

  UpdateVisitorInfoBloc({AddVisitorRepository? addVisitorRepository})
      : _addVisitorRepository = addVisitorRepository ?? AddVisitorRepository(),
        super(Default());

  Future updateVisitorInfo({
    required Map<String, dynamic> indianVisitorInfo,
  }) {
    emit(Progress());
    return _addVisitorRepository
        .updateVisitorInfo(
          indianVisitorInfo: indianVisitorInfo,
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
