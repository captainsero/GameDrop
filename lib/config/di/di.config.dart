// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:hive_ce/hive.dart' as _i738;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/games/api/api_client/games_api_client.dart' as _i980;
import '../../features/games/api/data_sources/games_local_data_source_impl.dart'
    as _i688;
import '../../features/games/api/data_sources/games_remote_data_source_impl.dart'
    as _i411;
import '../../features/games/data/data_sources/games_local_data_source_contract.dart'
    as _i487;
import '../../features/games/data/data_sources/games_remote_data_source_contract.dart'
    as _i420;
import '../../features/games/data/repo/games_repo_impl.dart' as _i854;
import '../../features/games/domain/repo/games_repo_contract.dart' as _i457;
import '../../features/games/domain/use_cases/get_upcoming_games_use_case.dart'
    as _i242;
import '../../features/games/domain/use_cases/search_games_use_case.dart'
    as _i1030;
import '../../features/games/presentation/view_model/games_view_model.dart'
    as _i55;
import '../dio/dio_module.dart' as _i977;
import '../hive/hive_module.dart' as _i523;
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
    final dioModule = _$DioModule();
    final hiveModule = _$HiveModule();
    gh.singleton<_i361.Dio>(() => dioModule.dio());
    gh.singleton<_i349.SecureStorageService>(
      () => _i349.SecureStorageService(),
    );
    gh.factory<_i293.LauncherService>(() => _i316.LauncherServiceImpl());
    gh.singleton<_i738.Box<dynamic>>(
      () => hiveModule.gamesBox(),
      instanceName: 'games_box',
    );
    gh.factory<_i980.GamesApiClient>(
      () => _i980.GamesApiClient(gh<_i361.Dio>()),
    );
    gh.factory<_i487.GamesLocalDataSourceContract>(
      () => _i688.GamesLocalDataSourceImpl(
        gh<_i738.Box<dynamic>>(instanceName: 'games_box'),
      ),
    );
    gh.factory<_i420.GamesRemoteDataSourceContract>(
      () => _i411.GamesRemoteDataSourceImpl(
        apiClient: gh<_i980.GamesApiClient>(),
      ),
    );
    gh.factory<_i457.GamesRepoContract>(
      () => _i854.GamesRepoImpl(
        remoteDataSource: gh<_i420.GamesRemoteDataSourceContract>(),
        localDataSource: gh<_i487.GamesLocalDataSourceContract>(),
      ),
    );
    gh.factory<_i242.GetUpcomingGamesUseCase>(
      () => _i242.GetUpcomingGamesUseCase(
        repoContract: gh<_i457.GamesRepoContract>(),
      ),
    );
    gh.factory<_i1030.SearchGamesUseCase>(
      () => _i1030.SearchGamesUseCase(
        repoContract: gh<_i457.GamesRepoContract>(),
      ),
    );
    gh.factory<_i55.GamesViewModel>(
      () => _i55.GamesViewModel(
        getUpcomingGamesUseCase: gh<_i242.GetUpcomingGamesUseCase>(),
        searchGamesUseCase: gh<_i1030.SearchGamesUseCase>(),
      ),
    );
    return this;
  }
}

class _$DioModule extends _i977.DioModule {}

class _$HiveModule extends _i523.HiveModule {}
