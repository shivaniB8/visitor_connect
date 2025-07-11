import 'package:host_visitor_connect/features/invoices/data/network/api_service/receipts_api_service.dart';
import 'package:host_visitor_connect/features/invoices/data/network/responses/receipt_response.dart';

class ReceiptsRepository {
  final ReceiptsApiService _invoicesApiService;

  ReceiptsRepository({ReceiptsApiService? invoicesApiService})
      : _invoicesApiService = invoicesApiService ?? ReceiptsApiService();

  Future<ReceiptResponse> hostPaymentReceipt(pageNo) async {
    return _invoicesApiService.hostPaymentReceipts(pageNo: pageNo);
  }
}
