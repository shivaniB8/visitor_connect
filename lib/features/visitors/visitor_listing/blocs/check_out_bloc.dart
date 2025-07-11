import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/common/blocs/state_events/ui_state.dart';
import 'package:host_visitor_connect/common/extensions/future_extensions.dart';
import 'package:host_visitor_connect/features/visitors/visitor_listing/data/network/responses/check_out_response.dart';
import 'package:host_visitor_connect/features/visitors/visitor_listing/data/repos/visitor_repository.dart';

class CheckOutBloc extends Cubit<UiState<CheckOutResponse>> {
  final VisitorRepository _visitorRepository;

  CheckOutBloc({VisitorRepository? visitorRepository})
      : _visitorRepository = visitorRepository ?? VisitorRepository(),
        super(Default());

  Future visitorCheckout({
    required int visitorId,
    String? checkOutDate,
    String? checkOutTime,
  }) {
    emit(Progress());
    return _visitorRepository
        .visitorCheckout(
            visitorId: visitorId,
            checkOutTime: checkOutTime,
            checkOutDate: checkOutDate)
        .then(_onSuccess)
        .handleError(_onError);
  }

  _onSuccess(CheckOutResponse checkOutResponse) async {
    emit(Success(checkOutResponse));
  }

  void _onError(exception) {
    log("on error visitor checkout ? $exception");
    emit(Error(exception as Exception));
  }
}
