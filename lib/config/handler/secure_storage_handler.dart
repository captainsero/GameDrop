import '../base_response/base_response.dart';

abstract class SecureStorageHandler {
  static T? handle<T>(
    BaseResponse<T> response, {
    T? defaultValue,
    void Function(String? errorMessage)? onError,
  }) {
    switch (response) {
      case SuccessBaseResponse<T>():
        return response.data;

      case ErrorBaseResponse<T>():
        onError?.call(response.errorMessage);
        return defaultValue;
    }
  }
}
