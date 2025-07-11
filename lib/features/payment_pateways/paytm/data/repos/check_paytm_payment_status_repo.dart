import 'package:host_visitor_connect/features/payment_pateways/paytm/data/api_services/check_paytm_payment_status.dart';
import 'package:host_visitor_connect/features/payment_pateways/paytm/data/models/paytm_payment_status_resp.dart';

class CheckPaytmPaymentStatusTokenRepository {
  final CheckPaytmPaymentStatusApiService _apiService;

  CheckPaytmPaymentStatusTokenRepository(
      {CheckPaytmPaymentStatusApiService? apiService})
      : _apiService = apiService ?? CheckPaytmPaymentStatusApiService();

  Future<CheckPaytmPaymentStatusResponse> generateCheckPaytmPaymentStatusToken(
      {required String orderId}) {
    return _apiService.generateCheckPaytmPaymentStatusToken(orderId: orderId);
  }
}
