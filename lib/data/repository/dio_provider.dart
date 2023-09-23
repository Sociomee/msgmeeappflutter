import 'package:dio/dio.dart';

import '../repositories.dart';

class ApiService {
  static final Dio _dio = Dio();

  // Base URL for your API
  static  String baseUrl = mainbaseUrl;

  // Singleton constructor
  ApiService._internal();

  static final ApiService _instance = ApiService._internal();

  factory ApiService() {
    // Add default headers here
    _dio.options.headers = {
      'Content-Type': 'application/json',
    };

    // Add any other default configurations you need here
    _dio.options.connectTimeout =
        const Duration(milliseconds: 15000); // 5 seconds
    _dio.options.receiveTimeout =
        const Duration(milliseconds: 15000); // 5 seconds

    return _instance;
  }

  Dio get dio => _dio;

  // Function to add headers
  void addHeaders(Map<String, dynamic> headers) {
    _dio.options.headers.addAll(headers);
  }

  // Function to change the base URL
  void changeBaseUrl(String newBaseUrl) {
    _dio.options.baseUrl = newBaseUrl;
  }
}
