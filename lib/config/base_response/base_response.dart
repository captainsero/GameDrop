import '../../core/errors/app_error.dart';

sealed class BaseResponse<T> {
  const BaseResponse();
}

class SuccessBaseResponse<T> extends BaseResponse<T> {
  const SuccessBaseResponse({required this.data});

  final T data;
}

class ErrorBaseResponse<T> extends BaseResponse<T> {
  const ErrorBaseResponse({this.error, this.errorMessage});

  final Object? error;
  final String? errorMessage;

  AppError get appError => AppError.from(error);
}
