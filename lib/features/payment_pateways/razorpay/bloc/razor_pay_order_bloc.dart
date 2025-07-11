import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/common/blocs/state_events/ui_state.dart';
import 'package:host_visitor_connect/common/extensions/future_extensions.dart';
import 'package:host_visitor_connect/features/payment_pateways/razorpay/data/repos/razor_pay_repository.dart';
import 'package:host_visitor_connect/features/payment_pateways/razorpay/data/responses/razor_pay_order_response_data.dart';

class RazorPayOrderBloc extends Cubit<UiState<RazorPayOrderResponseData>> {
  final RazorPayRepository _razorPayRepository;

  RazorPayOrderBloc({RazorPayRepository? razorPayRepository})
      : _razorPayRepository = razorPayRepository ?? RazorPayRepository(),
        super(Default());

  Future createOrderRazorpay({required int amount, required String reason}) {
    emit(Progress());
    return _razorPayRepository
        .createOrderRazorpay(
          amount: amount,
          reason: reason,
        )
        .then(_onSuccess)
        .handleError(_onError);
  }

  _onSuccess(RazorPayOrderResponseData razorPayOrderResponseData) async {
    emit(Success(razorPayOrderResponseData));
  }

  _onError(exception) {
    emit(Error(exception as Exception));
  }
}
