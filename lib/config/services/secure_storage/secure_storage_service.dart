import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import '../../base_response/base_response.dart';

@singleton
class SecureStorageService {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<BaseResponse<String>> write({
    required String key,
    required String value,
  }) async {
    try {
      await _storage.write(key: key, value: value);
      return SuccessBaseResponse(data: key);
    } on Exception catch (e) {
      return ErrorBaseResponse(error: e);
    }
  }

  Future<BaseResponse<String>> read({required String key}) async {
    try {
      final value = await _storage.read(key: key);

      if (value == null) {
        return ErrorBaseResponse(error: KeyNotFoundException(key));
      }

      return SuccessBaseResponse(data: value);
    } on Exception catch (e) {
      return ErrorBaseResponse(error: e);
    }
  }

  Future<BaseResponse<bool>> delete({required String key}) async {
    try {
      await _storage.delete(key: key);
      return const SuccessBaseResponse(data: true);
    } on Exception catch (e) {
      return ErrorBaseResponse(error: e);
    }
  }

  Future<BaseResponse<bool>> deleteAll() async {
    try {
      await _storage.deleteAll();
      return const SuccessBaseResponse(data: true);
    } on Exception catch (e) {
      return ErrorBaseResponse(error: e);
    }
  }
}

class KeyNotFoundException implements Exception {
  KeyNotFoundException(this.key);

  final String key;
}
