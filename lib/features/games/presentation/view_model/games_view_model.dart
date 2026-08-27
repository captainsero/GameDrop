import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../config/base_state/base_state.dart';
import '../../../../config/handler/response_to_state_mapper.dart';
import '../../domain/entities/game_entity.dart';
import '../../domain/use_cases/get_upcoming_games_use_case.dart';
import '../../domain/use_cases/search_games_use_case.dart';
import 'games_event.dart';
import 'games_state.dart';

@injectable
class GamesViewModel extends Cubit<GamesState> {
  GamesViewModel({
    required GetUpcomingGamesUseCase getUpcomingGamesUseCase,
    required SearchGamesUseCase searchGamesUseCase,
  })  : _getUpcomingGamesUseCase = getUpcomingGamesUseCase,
        _searchGamesUseCase = searchGamesUseCase,
        super(const GamesState());

  final GetUpcomingGamesUseCase _getUpcomingGamesUseCase;
  final SearchGamesUseCase _searchGamesUseCase;

  Future<void> onEvent(GamesEvent event) async {
    switch (event) {
      case GetUpcomingGamesEvent():
        await _getUpcomingGames(page: event.page);
      case OpenSearchEvent():
        _openSearch();
      case CloseSearchEvent():
        _closeSearch();
      case SearchGamesEvent():
        await _searchGames(query: event.query);
      case ClearSearchEvent():
        _clearSearch();
    }
  }

  Future<void> _getUpcomingGames({required int page}) async {
    emit(
      state.copyWith(
        getUpcomingGamesState: const BaseState(isLoading: true),
      ),
    );

    final response = await _getUpcomingGamesUseCase(page: page);
    final handler = ResponseToStateMapper.handle(response);

    emit(state.copyWith(getUpcomingGamesState: handler));
  }

  void _openSearch() {
    emit(state.copyWith(isSearchActive: true));
  }

  void _closeSearch() {
    emit(
      state.copyWith(
        isSearchActive: false,
        searchGamesState: const BaseState<List<GameEntity>>(),
      ),
    );
  }

  Future<void> _searchGames({required String query}) async {
    emit(
      state.copyWith(
        searchGamesState: const BaseState<List<GameEntity>>(isLoading: true),
      ),
    );

    final response = await _searchGamesUseCase(query: query);
    final handler = ResponseToStateMapper.handle(response);

    emit(state.copyWith(searchGamesState: handler));
  }

  void _clearSearch() {
    emit(
      state.copyWith(
        searchGamesState: const BaseState<List<GameEntity>>(),
      ),
    );
  }
}
