import 'package:host_visitor_connect/features/payment_pateways/paytm/data/api_services/gerenerate_paytm_token.dart';
import 'package:host_visitor_connect/features/payment_pateways/paytm/data/models/paytm_token_response.dart';

class PaytmTokenRepository {
  final PaytmApiService _apiService;

  PaytmTokenRepository({PaytmApiService? apiService})
      : _apiService = apiService ?? PaytmApiService();

  Future<PaytmTokenResponse> generatePaytmToken({
    required int amount,
    required int hostId,
  }) {
    return _apiService.generatePaytmToken(amount: amount, hostId: hostId);
  }
}
