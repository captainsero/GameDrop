import 'package:flutter_test/flutter_test.dart';
import 'package:gamedrop/features/game_details/domain/entities/game_detail_entity.dart';

void main() {
  group('GameDetailEntity', () {
    test('instantiates with all fields correctly', () {
      final releaseDate = DateTime(2027, 5, 20);
      final entity = GameDetailEntity(
        id: 99,
        name: 'The Witcher 4',
        coverUrl: 'https://example.com/witcher4.png',
        releaseDate: releaseDate,
        tba: false,
        platforms: const ['PC', 'PS5', 'Xbox Series X'],
        summary: 'A new saga begins in the Witcher universe.',
      );

      expect(entity.id, 99);
      expect(entity.name, 'The Witcher 4');
      expect(entity.coverUrl, 'https://example.com/witcher4.png');
      expect(entity.releaseDate, releaseDate);
      expect(entity.tba, false);
      expect(entity.platforms, ['PC', 'PS5', 'Xbox Series X']);
      expect(entity.summary, 'A new saga begins in the Witcher universe.');
    });

    group('daysUntilRelease', () {
      test('returns null when releaseDate is null', () {
        const entity = GameDetailEntity(
          id: 99,
          name: 'TBA Title',
          coverUrl: null,
          releaseDate: null,
          tba: true,
          platforms: [],
          summary: '',
        );

        expect(entity.daysUntilRelease, isNull);
      });

      test('returns positive days when releaseDate is in future', () {
        final entity = GameDetailEntity(
          id: 99,
          name: 'Future Title',
          coverUrl: null,
          releaseDate: DateTime.now().add(const Duration(days: 30)),
          tba: false,
          platforms: [],
          summary: '',
        );

        expect(entity.daysUntilRelease, isNotNull);
        expect(entity.daysUntilRelease, greaterThanOrEqualTo(29));
      });

      test('returns 0 when releaseDate is in past', () {
        final entity = GameDetailEntity(
          id: 99,
          name: 'Old Title',
          coverUrl: null,
          releaseDate: DateTime.now().subtract(const Duration(days: 5)),
          tba: false,
          platforms: [],
          summary: '',
        );

        expect(entity.daysUntilRelease, 0);
      });
    });
  });
}
