class GameEntity {
  const GameEntity({
    required this.id,
    required this.name,
    required this.coverUrl,
    required this.releaseDate,
    required this.tba,
    required this.platforms,
  });

  final int id;
  final String name;
  final String? coverUrl;
  final DateTime? releaseDate;
  final bool tba;
  final List<String> platforms;

  int? get daysUntilRelease {
    if (releaseDate == null) return null;
    final diff = releaseDate!.difference(DateTime.now()).inDays;
    return diff < 0 ? 0 : diff;
  }
}
