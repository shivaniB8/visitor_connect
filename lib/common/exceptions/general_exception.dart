import 'package:host_visitor_connect/common/data/network/responses/api_error_response.dart';

class GeneralException implements Exception {
  ApiErrorResponse? apiError;

  GeneralException([this.apiError]);

  @override
  String toString() {
    return apiError?.errors ?? '';
  }
}
