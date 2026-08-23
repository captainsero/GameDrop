// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../services/launcher_service/launcher_service.dart' as _i293;
import '../services/launcher_service/launcher_service_impl.dart' as _i316;
import '../services/secure_storage/secure_storage_service.dart' as _i349;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.singleton<_i349.SecureStorageService>(
      () => _i349.SecureStorageService(),
    );
    gh.factory<_i293.LauncherService>(() => _i316.LauncherServiceImpl());
    return this;
  }
}
