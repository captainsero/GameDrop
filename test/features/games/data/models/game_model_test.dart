import 'package:flutter_test/flutter_test.dart';
import 'package:gamedrop/features/games/data/models/game_model.dart';

void main() {
  group('GameModel', () {
    const tJson = <String, dynamic>{
      'id': 123,
      'name': 'Hollow Knight: Silksong',
      'coverUrl': 'https://image.api.com/cover.png',
      'releaseDate': '2026-11-15',
      'tba': false,
      'platforms': ['PC', 'Nintendo Switch', 'PS5'],
    };

    const tModel = GameModel(
      id: 123,
      name: 'Hollow Knight: Silksong',
      coverUrl: 'https://image.api.com/cover.png',
      releaseDate: '2026-11-15',
      tba: false,
      platforms: ['PC', 'Nintendo Switch', 'PS5'],
    );

    test('fromJson should return valid GameModel from json map', () {
      final model = GameModel.fromJson(tJson);

      expect(model.id, 123);
      expect(model.name, 'Hollow Knight: Silksong');
      expect(model.coverUrl, 'https://image.api.com/cover.png');
      expect(model.releaseDate, '2026-11-15');
      expect(model.tba, false);
      expect(model.platforms, ['PC', 'Nintendo Switch', 'PS5']);
    });

    test('toJson should return map containing expected keys and values', () {
      final json = tModel.toJson();

      expect(json, tJson);
    });

    group('toEntity', () {
      test(
        'should correctly map GameModel to GameEntity with valid releaseDate',
        () {
          final entity = tModel.toEntity();

          expect(entity.id, tModel.id);
          expect(entity.name, tModel.name);
          expect(entity.coverUrl, tModel.coverUrl);
          expect(entity.releaseDate, DateTime.parse('2026-11-15'));
          expect(entity.tba, tModel.tba);
          expect(entity.platforms, tModel.platforms);
        },
      );

      test('should handle null releaseDate gracefully in toEntity', () {
        const modelWithNullDate = GameModel(
          id: 456,
          name: 'GTA VI',
          coverUrl: null,
          releaseDate: null,
          tba: true,
          platforms: ['PS5', 'Xbox Series X'],
        );

        final entity = modelWithNullDate.toEntity();

        expect(entity.id, 456);
        expect(entity.name, 'GTA VI');
        expect(entity.coverUrl, isNull);
        expect(entity.releaseDate, isNull);
        expect(entity.tba, true);
        expect(entity.platforms, ['PS5', 'Xbox Series X']);
      });

      test(
        'should handle invalid date format gracefully (null releaseDate)',
        () {
          const modelWithInvalidDate = GameModel(
            id: 789,
            name: 'Invalid Date Game',
            coverUrl: null,
            releaseDate: 'not-a-valid-date',
            tba: false,
            platforms: [],
          );

          final entity = modelWithInvalidDate.toEntity();

          expect(entity.releaseDate, isNull);
        },
      );
    });
  });
}
