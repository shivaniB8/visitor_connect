import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/common/blocs/state_events/ui_state.dart';
import 'package:host_visitor_connect/common/extensions/future_extensions.dart';
import 'package:host_visitor_connect/features/invoices/data/network/responses/invoices_response.dart';
import 'package:host_visitor_connect/features/invoices/data/network/responses/receipt_response.dart';
import 'package:host_visitor_connect/features/invoices/data/repos/recipts_repository.dart';

class ReceiptsBloc extends Cubit<UiState<ReceiptResponse>> {
  final ReceiptsRepository _invoicesRepository;

  ReceiptsBloc({ReceiptsRepository? invoicesRepository})
      : _invoicesRepository = invoicesRepository ?? ReceiptsRepository(),
        super(Default());

  void getReceiptList() {
    emit(Progress());
    _invoicesRepository
        .hostPaymentReceipt(0)
        .then(_onSuccess)
        .handleError(_onError);
  }

  void _onSuccess(ReceiptResponse invoicesResponse) {
    emit(Success(invoicesResponse));
  }

  _onError(exception) {
    emit(Error(exception as Exception));
  }
}
