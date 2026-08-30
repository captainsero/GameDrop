import 'package:flutter_test/flutter_test.dart';
import 'package:gamedrop/features/game_details/data/models/game_detail_model.dart';

void main() {
  group('GameDetailModel', () {
    const tJson = <String, dynamic>{
      'id': 50,
      'name': 'Fable',
      'coverUrl': 'https://example.com/fable.png',
      'releaseDate': '2026-12-01',
      'tba': false,
      'platforms': ['Xbox Series X', 'PC'],
      'summary': 'A fresh start for the legendary franchise.',
    };

    const tModel = GameDetailModel(
      id: 50,
      name: 'Fable',
      coverUrl: 'https://example.com/fable.png',
      releaseDate: '2026-12-01',
      tba: false,
      platforms: ['Xbox Series X', 'PC'],
      summary: 'A fresh start for the legendary franchise.',
    );

    test('fromJson returns valid GameDetailModel from json map', () {
      final model = GameDetailModel.fromJson(tJson);

      expect(model.id, 50);
      expect(model.name, 'Fable');
      expect(model.coverUrl, 'https://example.com/fable.png');
      expect(model.releaseDate, '2026-12-01');
      expect(model.tba, false);
      expect(model.platforms, ['Xbox Series X', 'PC']);
      expect(model.summary, 'A fresh start for the legendary franchise.');
    });

    test('toJson returns map matching expected format', () {
      final json = tModel.toJson();

      expect(json, tJson);
    });

    group('toEntity', () {
      test('correctly maps to GameDetailEntity with valid date', () {
        final entity = tModel.toEntity();

        expect(entity.id, tModel.id);
        expect(entity.name, tModel.name);
        expect(entity.coverUrl, tModel.coverUrl);
        expect(entity.releaseDate, DateTime.parse('2026-12-01'));
        expect(entity.tba, tModel.tba);
        expect(entity.platforms, tModel.platforms);
        expect(entity.summary, tModel.summary);
      });

      test('handles null releaseDate gracefully', () {
        const nullDateModel = GameDetailModel(
          id: 51,
          name: 'Silent Hill f',
          coverUrl: null,
          releaseDate: null,
          tba: true,
          platforms: ['PS5'],
          summary: 'A new terrifying story.',
        );

        final entity = nullDateModel.toEntity();

        expect(entity.releaseDate, isNull);
        expect(entity.tba, isTrue);
      });
    });
  });
}
