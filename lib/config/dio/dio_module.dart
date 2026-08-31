import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import 'dio_config.dart';

@module
abstract class DioModule {
  @singleton
  Dio dio() => DioConfig.createDio();
}
