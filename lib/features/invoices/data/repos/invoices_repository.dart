import 'package:host_visitor_connect/features/invoices/data/network/api_service/invoices_api_service.dart';
import 'package:host_visitor_connect/features/invoices/data/network/responses/invoices_response.dart';

class InvoicesRepository {
  final InvoicesApiService _invoicesApiService;

  InvoicesRepository({InvoicesApiService? invoicesApiService})
      : _invoicesApiService = invoicesApiService ?? InvoicesApiService();

  Future<InvoicesResponse> invoiceList() async {
    return _invoicesApiService.invoicesList();
  }


}
