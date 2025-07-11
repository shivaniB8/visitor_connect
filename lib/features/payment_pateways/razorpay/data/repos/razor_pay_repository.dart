import 'package:host_visitor_connect/features/payment_pateways/razorpay/data/api_services/razor_pay_api_service.dart';
import 'package:host_visitor_connect/features/payment_pateways/razorpay/data/responses/razor_pay_order_response_data.dart';
import 'package:host_visitor_connect/features/payment_pateways/razorpay/data/responses/razor_pay_transaction_response.dart';

class RazorPayRepository {
  final RazorPayApiService _razorPayApiService;

  RazorPayRepository({RazorPayApiService? razorPayApiService})
      : _razorPayApiService = razorPayApiService ?? RazorPayApiService();

  Future<RazorPayOrderResponseData> createOrderRazorpay({
    required int amount,
    required String reason,
  }) {
    return _razorPayApiService.createOrderRazorpay(
      amount: amount,
      reason: reason,
    );
  }

  Future<RazorPayTransactionResponse> razorpayPayment({
    required String transactionId,
  }) {
    return _razorPayApiService.razorpayPayment(
      transactionId: transactionId,
    );
  }
}
