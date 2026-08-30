import 'package:flutter_test/flutter_test.dart';
import 'package:gamedrop/features/game_details/data/models/game_detail_model.dart';
import 'package:gamedrop/features/game_details/data/models/game_detail_model_adapter.dart';
import 'package:hive_ce/hive.dart';
import 'package:mocktail/mocktail.dart';

class MockBinaryReader extends Mock implements BinaryReader {}

class MockBinaryWriter extends Mock implements BinaryWriter {}

void main() {
  late GameDetailModelAdapter adapter;

  setUp(() {
    adapter = GameDetailModelAdapter();
  });

  group('GameDetailModelAdapter', () {
    test('typeId should be 1', () {
      expect(adapter.typeId, 1);
    });

    test('write writes all 7 fields to BinaryWriter', () {
      final writer = MockBinaryWriter();
      const model = GameDetailModel(
        id: 77,
        name: 'Gears 6',
        coverUrl: 'https://example.com/gears.png',
        releaseDate: '2026-11-11',
        tba: false,
        platforms: ['Xbox Series X'],
        summary: 'The battle continues.',
      );

      adapter.write(writer, model);

      verify(() => writer.writeByte(7)).called(1);
      verify(() => writer.writeByte(0)).called(1);
      verify(() => writer.write(77)).called(1);
      verify(() => writer.writeByte(1)).called(1);
      verify(() => writer.write('Gears 6')).called(1);
      verify(() => writer.writeByte(2)).called(1);
      verify(
        () => writer.write<String?>('https://example.com/gears.png'),
      ).called(1);
      verify(() => writer.writeByte(3)).called(1);
      verify(() => writer.write<String?>('2026-11-11')).called(1);
      verify(() => writer.writeByte(4)).called(1);
      verify(() => writer.write(false)).called(1);
      verify(() => writer.writeByte(5)).called(1);
      verify(() => writer.write(['Xbox Series X'])).called(1);
      verify(() => writer.writeByte(6)).called(1);
      verify(() => writer.write('The battle continues.')).called(1);
    });

    test('read constructs GameDetailModel from BinaryReader', () {
      final reader = MockBinaryReader();

      final bytes = [7, 0, 1, 2, 3, 4, 5, 6];
      var byteIdx = 0;
      when(() => reader.readByte()).thenAnswer((_) => bytes[byteIdx++]);

      final values = <dynamic>[
        88,
        'Judas',
        null,
        '2026-08-01',
        false,
        <dynamic>['PC', 'PS5'],
        'Disintegrate the system.',
      ];
      var valIdx = 0;
      when(() => reader.read()).thenAnswer((_) => values[valIdx++]);

      final result = adapter.read(reader);

      expect(result.id, 88);
      expect(result.name, 'Judas');
      expect(result.coverUrl, isNull);
      expect(result.releaseDate, '2026-08-01');
      expect(result.tba, false);
      expect(result.platforms, ['PC', 'PS5']);
      expect(result.summary, 'Disintegrate the system.');
    });

    test('equality and hashCode match by typeId', () {
      final adapter1 = GameDetailModelAdapter();
      final adapter2 = GameDetailModelAdapter();

      expect(adapter1 == adapter2, isTrue);
      expect(adapter1.hashCode, adapter2.hashCode);
    });
  });
}
