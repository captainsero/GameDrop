import 'package:flutter_test/flutter_test.dart';
import 'package:gamedrop/features/games/domain/entities/game_entity.dart';

void main() {
  group('GameEntity', () {
    test('should correctly instantiate GameEntity with all fields', () {
      final releaseDate = DateTime(2026, 12, 25);
      final entity = GameEntity(
        id: 1,
        name: 'Cyber Horizon',
        coverUrl: 'https://example.com/cover.jpg',
        releaseDate: releaseDate,
        tba: false,
        platforms: const ['PC', 'PlayStation 5'],
      );

      expect(entity.id, 1);
      expect(entity.name, 'Cyber Horizon');
      expect(entity.coverUrl, 'https://example.com/cover.jpg');
      expect(entity.releaseDate, releaseDate);
      expect(entity.tba, false);
      expect(entity.platforms, ['PC', 'PlayStation 5']);
    });

    group('daysUntilRelease', () {
      test('should return null when releaseDate is null', () {
        const entity = GameEntity(
          id: 1,
          name: 'Mystery Game',
          coverUrl: null,
          releaseDate: null,
          tba: true,
          platforms: ['PC'],
        );

        expect(entity.daysUntilRelease, isNull);
      });

      test('should return positive days when releaseDate is in the future', () {
        final futureDate = DateTime.now().add(const Duration(days: 15));
        final entity = GameEntity(
          id: 1,
          name: 'Future Game',
          coverUrl: null,
          releaseDate: futureDate,
          tba: false,
          platforms: ['PC'],
        );

        // Depending on hour fraction, difference in days is >= 14
        expect(entity.daysUntilRelease, isNotNull);
        expect(entity.daysUntilRelease, greaterThanOrEqualTo(14));
      });

      test('should return 0 when releaseDate is in the past', () {
        final pastDate = DateTime.now().subtract(const Duration(days: 10));
        final entity = GameEntity(
          id: 1,
          name: 'Released Game',
          coverUrl: null,
          releaseDate: pastDate,
          tba: false,
          platforms: ['PC'],
        );

        expect(entity.daysUntilRelease, 0);
      });
    });
  });
}
