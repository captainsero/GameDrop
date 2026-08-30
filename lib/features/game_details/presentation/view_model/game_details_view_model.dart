import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../config/base_state/base_state.dart';
import '../../../../config/handler/response_to_state_mapper.dart';
import '../../domain/use_cases/get_game_detail_use_case.dart';
import 'game_details_event.dart';
import 'game_details_state.dart';

@injectable
class GameDetailsViewModel extends Cubit<GameDetailsState> {
  GameDetailsViewModel({
    required GetGameDetailUseCase getGameDetailUseCase,
  }) : _getGameDetailUseCase = getGameDetailUseCase,
       super(const GameDetailsState());

  final GetGameDetailUseCase _getGameDetailUseCase;

  Future<void> onEvent(GameDetailsEvent event) async {
    switch (event) {
      case GetGameDetailEvent():
        await _getGameDetail(id: event.id);
    }
  }

  Future<void> _getGameDetail({required int id}) async {
    emit(
      state.copyWith(
        getGameDetailState: const BaseState(isLoading: true),
      ),
    );

    final response = await _getGameDetailUseCase(id: id);
    final handler = ResponseToStateMapper.handle(response);

    emit(state.copyWith(getGameDetailState: handler));
  }
}
