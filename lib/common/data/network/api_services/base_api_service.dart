import 'package:dio/dio.dart';
import 'package:host_visitor_connect/build_config.dart';
import 'package:host_visitor_connect/common/data/network/api_services/dio_client.dart';
import 'package:host_visitor_connect/common/data/network/responses/api_error_response.dart';
import 'package:host_visitor_connect/common/exceptions/general_exception.dart';
import 'package:host_visitor_connect/common/res/keys.dart';
import 'package:host_visitor_connect/common/shared_prefs.dart';

class BaseApiService {
  final Dio httpClient;

  BaseApiService(dynamic client) : httpClient = client ?? DioClient().client;

  /// Creates URI for API calls
  Uri getUri(String path) {
    final String uriPath = path.startsWith('/') ? path : '/$path';
    print(Uri(
      scheme: BuildConfig.instance?.scheme,
      host: BuildConfig.instance?.apiBaseUrl,
      path: uriPath,
    ));
    return Uri(
      scheme: BuildConfig.instance?.scheme,
      host: BuildConfig.instance?.apiBaseUrl,
      path: uriPath,
    );
  }

  /// Sends requests & parses response for success/error handling
  Future<Response> send(Future<Response> request) async {
    try {
      final response = await request;
      print('response--> $response');
      return response;
    } on DioException catch (error) {
      print('error--> $error');
      if (error.response != null) {
        return _handleError(error.response!);
      } else if (error.type == DioExceptionType.unknown) {
        throw error.error ?? Error();
      }
      throw GeneralException();
    }
  }

  Future<Response> _handleError(Response response) {
    final apiError = _parseError(response);
    throw GeneralException(apiError);
  }

  ApiErrorResponse _parseError(Response response) {
    return ApiErrorResponse(errors: response.data);
  }

  String? getAuthToken() {
    return SharedPrefs.getString(apiAuthenticationToken);
  }

  String? getPhoneNo() {
    return SharedPrefs.getString(keyPhoneNo);
  }

  /// creates very basic headers api calls
  Options getOptions({
    Map<String, dynamic>? headers,
  }) {
    //request headers
    // final headers = getBaseHeaders();

    final options = Options(
      responseType: ResponseType.json,
      contentType: 'application/json',
      headers: headers,
    );
    return options;
  }

  Map<String, dynamic> getAuthQueryParams() {
    return {
      'user_login': getPhoneNo(),
      'user_token': getAuthToken(),
    };
  }
}
