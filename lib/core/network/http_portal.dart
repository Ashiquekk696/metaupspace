import 'package:dio/dio.dart';
import 'package:metaupspace/core/network/mock_interceptor.dart';

class HttpPortal {
  HttpPortal({Dio? dio}) : _dio = dio ?? Dio() {
    _dio.options = BaseOptions(
      baseUrl: 'https://api.metaupspace.mock/v1',
      connectTimeout: const Duration(seconds: 12),
      receiveTimeout: const Duration(seconds: 12),
      headers: <String, dynamic>{'Accept': 'application/json'},
    );
    _dio.interceptors.add(MockInterceptor());
  }

  final Dio _dio;

  Dio get client => _dio;
}
