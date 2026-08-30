sealed class GameDetailsEvent {}

class GetGameDetailEvent extends GameDetailsEvent {
  GetGameDetailEvent({required this.id});

  final int id;
}
