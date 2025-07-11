import 'package:dio/dio.dart';

class DioClient {
  static final DioClient _dioClient = DioClient._internal();
  late final Dio _client;

  factory DioClient() {
    return _dioClient;
  }

  DioClient._internal() {
    _client = Dio();
  }

  Dio get client => _client;
}
