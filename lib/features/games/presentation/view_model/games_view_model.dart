import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../config/base_state/base_state.dart';
import '../../../../config/handler/response_to_state_mapper.dart';
import '../../domain/use_cases/get_upcoming_games_use_case.dart';
import 'games_event.dart';
import 'games_state.dart';

@injectable
class GamesViewModel extends Cubit<GamesState> {
  GamesViewModel({required GetUpcomingGamesUseCase getUpcomingGamesUseCase})
    : _getUpcomingGamesUseCase = getUpcomingGamesUseCase,
      super(const GamesState());

  final GetUpcomingGamesUseCase _getUpcomingGamesUseCase;

  Future<void> onEvent(GamesEvent event) async {
    switch (event) {
      case GetUpcomingGamesEvent():
        await _getUpcomingGames(page: event.page);
    }
  }

  Future<void> _getUpcomingGames({required int page}) async {
    emit(
      state.copyWith(getUpcomingGamesState: const BaseState(isLoading: true)),
    );

    final response = await _getUpcomingGamesUseCase(page: page);
    final handler = ResponseToStateMapper.handle(response);

    emit(state.copyWith(getUpcomingGamesState: handler));
  }
}
