class GameDetailEntity {
  const GameDetailEntity({
    required this.id,
    required this.name,
    required this.coverUrl,
    required this.releaseDate,
    required this.tba,
    required this.platforms,
    required this.summary,
  });

  final int id;
  final String name;
  final String? coverUrl;
  final DateTime? releaseDate;
  final bool tba;
  final List<String> platforms;
  final String summary;

  int? get daysUntilRelease {
    if (releaseDate == null) return null;
    final diff = releaseDate!.difference(DateTime.now()).inDays;
    return diff < 0 ? 0 : diff;
  }
}
