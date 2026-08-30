sealed class GamesEvent {}

class GetUpcomingGamesEvent extends GamesEvent {
  GetUpcomingGamesEvent({required this.page});

  final int page;
}

class OpenSearchEvent extends GamesEvent {}

class CloseSearchEvent extends GamesEvent {}

class SearchGamesEvent extends GamesEvent {
  SearchGamesEvent({required this.query});

  final String query;
}

class ClearSearchEvent extends GamesEvent {}
