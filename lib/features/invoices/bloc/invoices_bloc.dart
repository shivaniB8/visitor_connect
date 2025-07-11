import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/common/blocs/state_events/ui_state.dart';
import 'package:host_visitor_connect/common/extensions/future_extensions.dart';
import 'package:host_visitor_connect/features/invoices/data/network/responses/invoices_response.dart';
import 'package:host_visitor_connect/features/invoices/data/repos/invoices_repository.dart';

class InvoicesBloc extends Cubit<UiState<InvoicesResponse>> {
  final InvoicesRepository _invoicesRepository;

  InvoicesBloc({InvoicesRepository? invoicesRepository})
      : _invoicesRepository = invoicesRepository ?? InvoicesRepository(),
        super(Default());

  void getInvoiceList() {
    emit(Progress());
    _invoicesRepository.invoiceList().then(_onSuccess).handleError(_onError);
  }

  void _onSuccess(InvoicesResponse invoicesResponse) {
    emit(Success(invoicesResponse));
  }

  _onError(exception) {
    emit(Error(exception as Exception));
  }
}
