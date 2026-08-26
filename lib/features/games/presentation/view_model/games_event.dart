sealed class GamesEvent {}

class GetUpcomingGamesEvent extends GamesEvent {
  GetUpcomingGamesEvent({required this.page});

  final int page;
}
