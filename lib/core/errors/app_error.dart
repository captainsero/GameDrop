import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';

import '../../config/services/secure_storage/secure_storage_service.dart';

sealed class AppError {
  const AppError();

  factory AppError.from(Object? error) {
    if (error is AppError) return error;
    if (error is DioException) {
      final data = error.response?.data;

      String? apiMessage;

      if (data is Map<String, dynamic>) {
        apiMessage = (data['message'] ?? data['error'])?.toString();
      } else if (data is String && data.isNotEmpty) {
        try {
          final decoded = jsonDecode(data) as Map<String, dynamic>;
          apiMessage = (decoded['message'] ?? decoded['error'])?.toString();
        } on FormatException catch (_) {
          // raw string is not JSON, ignore
        }
      }

      if (apiMessage != null && apiMessage.isNotEmpty) {
        return ApiMessageError(apiMessage);
      }

      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          return const ConnectionTimeoutError();

        case DioExceptionType.badResponse:
          final statusCode = error.response?.statusCode ?? 0;
          if (statusCode >= 500) return ServerError(statusCode);
          if (statusCode == 404) return const NotFoundError();
          return const UnknownError();

        case DioExceptionType.unknown:
          return const NetworkError();

        case DioExceptionType.cancel:
        case DioExceptionType.badCertificate:
        case DioExceptionType.connectionError:
        case DioExceptionType.transformTimeout:
          return const UnknownError();
      }
    }

    if (error is TimeoutException) return const RequestTimeoutError();

    if (error is KeyNotFoundException) {
      return LocalStorageError(key: error.key);
    }

    if (error is PlatformException) {
      return const LocalStorageError();
    }

    return const UnknownError();
  }
}

class ConnectionTimeoutError extends AppError {
  const ConnectionTimeoutError();
}

class RequestTimeoutError extends AppError {
  const RequestTimeoutError();
}

class NetworkError extends AppError {
  const NetworkError();
}

class NotFoundError extends AppError {
  const NotFoundError();
}

class ServiceDisabled extends AppError {
  const ServiceDisabled();
}

class PermissionDenied extends AppError {
  const PermissionDenied();
}

class PermissionDeniedForever extends AppError {
  const PermissionDeniedForever();
}

class ServerError extends AppError {
  const ServerError(this.statusCode);

  final int statusCode;
}

class ApiMessageError extends AppError {
  const ApiMessageError(this.message);

  final String message;
}

class UnknownError extends AppError {
  const UnknownError();
}

class LocalStorageError extends AppError {
  const LocalStorageError({this.key});

  final String? key;
}
