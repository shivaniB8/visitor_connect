import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/common/blocs/state_events/ui_state.dart';
import 'package:host_visitor_connect/common/extensions/future_extensions.dart';
import 'package:host_visitor_connect/features/payment_pateways/paytm/data/models/paytm_payment_status_resp.dart';
import 'package:host_visitor_connect/features/payment_pateways/paytm/data/repos/check_paytm_payment_status_repo.dart';

class CheckPaytmPaymentStatusTokenBloc
    extends Cubit<UiState<CheckPaytmPaymentStatusResponse>> {
  final CheckPaytmPaymentStatusTokenRepository _repository;

  CheckPaytmPaymentStatusTokenBloc(
      {CheckPaytmPaymentStatusTokenRepository? repository})
      : _repository = repository ?? CheckPaytmPaymentStatusTokenRepository(),
        super(Default());

  Future generateCheckPaytmPaymentStatusToken({required String orderId}) {
    emit(Progress());
    return _repository
        .generateCheckPaytmPaymentStatusToken(orderId: orderId)
        .then(_onSuccess)
        .handleError(_onError);
  }

  _onSuccess(CheckPaytmPaymentStatusResponse response) async {
    emit(Success(response));
  }

  _onError(exception) {
    emit(Error(exception as Exception));
  }
}
