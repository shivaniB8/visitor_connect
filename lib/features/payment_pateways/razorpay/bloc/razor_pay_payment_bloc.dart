import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/common/blocs/state_events/ui_state.dart';
import 'package:host_visitor_connect/common/extensions/future_extensions.dart';
import 'package:host_visitor_connect/features/payment_pateways/razorpay/data/repos/razor_pay_repository.dart';
import 'package:host_visitor_connect/features/payment_pateways/razorpay/data/responses/razor_pay_transaction_response.dart';

class RazorPayPaymentBloc extends Cubit<UiState<RazorPayTransactionResponse>> {
  final RazorPayRepository _razorPayRepository;

  RazorPayPaymentBloc({RazorPayRepository? razorPayRepository})
      : _razorPayRepository = razorPayRepository ?? RazorPayRepository(),
        super(Default());

  Future razorpayPayment({
    required String transactionId,
  }) {
    emit(Progress());
    return _razorPayRepository
        .razorpayPayment(
          transactionId: transactionId,
        )
        .then(_onSuccess)
        .handleError(_onError);
  }

  _onSuccess(RazorPayTransactionResponse razorPayTransactionResponse) async {
    emit(Success(razorPayTransactionResponse));
  }

  _onError(exception) {
    emit(Error(exception as Exception));
  }
}
