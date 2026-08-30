import 'package:flutter_test/flutter_test.dart';
import 'package:gamedrop/features/games/data/models/game_model.dart';
import 'package:gamedrop/features/games/data/models/games_response_model.dart';

void main() {
  group('GamesResponseModel', () {
    const tJson = <String, dynamic>{
      'count': 1,
      'next': false,
      'results': [
        {
          'id': 1,
          'name': 'Metroid Prime 4',
          'coverUrl': null,
          'releaseDate': '2026-09-01',
          'tba': false,
          'platforms': ['Nintendo Switch'],
        },
      ],
    };

    const tModel = GamesResponseModel(
      count: 1,
      next: false,
      results: [
        GameModel(
          id: 1,
          name: 'Metroid Prime 4',
          coverUrl: null,
          releaseDate: '2026-09-01',
          tba: false,
          platforms: ['Nintendo Switch'],
        ),
      ],
    );

    test('fromJson should return valid GamesResponseModel', () {
      final result = GamesResponseModel.fromJson(tJson);

      expect(result.count, 1);
      expect(result.next, false);
      expect(result.results.length, 1);
      expect(result.results.first.name, 'Metroid Prime 4');
    });

    test('toJson should return Map matching expected format', () {
      final result = tModel.toJson();

      expect(result['count'], 1);
      expect(result['next'], false);
      expect((result['results'] as List).length, 1);
    });
  });
}
