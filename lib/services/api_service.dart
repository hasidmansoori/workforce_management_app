import 'package:dio/dio.dart';

class ApiService {
  final Dio dio;
  ApiService(this.dio) {
    dio.options = BaseOptions(
      baseUrl: 'https://api.example.com', // change to your API
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {'Content-Type': 'application/json'},
    );

    dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
  }

  void setToken(String token) {
    dio.options.headers['Authorization'] = 'Bearer \$token';
  }
}
