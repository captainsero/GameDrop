import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../core/constants/app_keys/api_keys.dart';

class DioConfig {
  static Dio createDio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: ApiKeys.baseUrl,
        sendTimeout: const Duration(seconds: 20),
        connectTimeout: const Duration(seconds: 20),
        receiveTimeout: const Duration(seconds: 20),
      ),
    );

    if (kDebugMode) {
      dio.interceptors.add(
        LogInterceptor(
          requestBody: true,
          responseBody: true,
        ),
      );
    }

    // Later: add an interceptor here that catches DioException
    // and maps it to your AppError hierarchy before it bubbles
    // up to the repo layer — keeps that mapping in one place
    // instead of repeating try/catch in every data source.

    return dio;
  }
}
