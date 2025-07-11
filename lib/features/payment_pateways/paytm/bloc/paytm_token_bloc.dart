import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/common/blocs/state_events/ui_state.dart';
import 'package:host_visitor_connect/common/extensions/future_extensions.dart';
import 'package:host_visitor_connect/features/payment_pateways/paytm/data/models/paytm_token_response.dart';
import 'package:host_visitor_connect/features/payment_pateways/paytm/data/repos/generate_paytm_token_repository.dart';

class PaytmTokenBloc extends Cubit<UiState<PaytmTokenResponse>> {
  final PaytmTokenRepository _repository;

  PaytmTokenBloc({PaytmTokenRepository? repository})
      : _repository = repository ?? PaytmTokenRepository(),
        super(Default());

  Future generatePaytmToken({required int amount, required int hostId}) {
    emit(Progress());
    return _repository
        .generatePaytmToken(amount: amount, hostId: hostId)
        .then(_onSuccess)
        .handleError(_onError);
  }

  _onSuccess(PaytmTokenResponse response) async {
    emit(Success(response));
  }

  _onError(exception) {
    emit(Error(exception as Exception));
  }
}
