import 'package:host_visitor_connect/features/invoices/data/network/responses/invoice_data.dart';
import 'package:host_visitor_connect/features/invoices/data/network/responses/invoices_list_response.dart';

Map<String, List<InvoiceData>>? getInvoicesAsPerMonth(
    InvoicesListResponse? invoicesListResponse) {
  Map<String, List<InvoiceData>> map = {};

  invoicesListResponse?.toJson().forEach((key, value) {
    if (value.isNotEmpty) {
      map.addAll({
        key: List.generate(
            value.length, (index) => InvoiceData.fromJson(value[index]))
      });
    }
  });

  return map;
}
