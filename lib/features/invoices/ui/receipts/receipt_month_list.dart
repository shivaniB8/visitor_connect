// import 'package:host_visitor_connect/features/invoices/data/network/responses/invoices_list_response.dart';
// import 'package:host_visitor_connect/features/invoices/data/network/responses/receipt_data.dart';
// import 'package:host_visitor_connect/features/invoices/data/network/responses/receipt_response.dart';
//
// Map<String, List<ReceiptResponseData>>? getReceiptsAsPerMonth(
//     InvoicesListResponse? invoicesListResponse) {
//   Map<String, List<ReceiptData>> map = {};
//
//   invoicesListResponse?.toJson().forEach((key, value) {
//     if (value.isNotEmpty) {
//       map.addAll({
//         key: List.generate(
//             value.length, (index) => ReceiptData.fromJson(value[index]))
//       });
//     }
//   });
//
//   return map;
// }
