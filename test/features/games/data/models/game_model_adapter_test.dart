import 'package:flutter_test/flutter_test.dart';
import 'package:gamedrop/features/games/data/models/game_model.dart';
import 'package:gamedrop/features/games/data/models/game_model_adapter.dart';
import 'package:hive_ce/hive.dart';
import 'package:mocktail/mocktail.dart';

class MockBinaryReader extends Mock implements BinaryReader {}

class MockBinaryWriter extends Mock implements BinaryWriter {}

void main() {
  late GameModelAdapter adapter;

  setUp(() {
    adapter = GameModelAdapter();
  });

  group('GameModelAdapter', () {
    test('typeId should be 0', () {
      expect(adapter.typeId, 0);
    });

    test('write should write all 6 fields to BinaryWriter in order', () {
      final writer = MockBinaryWriter();
      const model = GameModel(
        id: 42,
        name: 'Persona 6',
        coverUrl: 'https://example.com/p6.png',
        releaseDate: '2026-10-10',
        tba: false,
        platforms: ['PS5'],
      );

      adapter.write(writer, model);

      verify(() => writer.writeByte(6)).called(1);
      verify(() => writer.writeByte(0)).called(1);
      verify(() => writer.write(42)).called(1);
      verify(() => writer.writeByte(1)).called(1);
      verify(() => writer.write('Persona 6')).called(1);
      verify(() => writer.writeByte(2)).called(1);
      verify(
        () => writer.write<String?>('https://example.com/p6.png'),
      ).called(1);
      verify(() => writer.writeByte(3)).called(1);
      verify(() => writer.write<String?>('2026-10-10')).called(1);
      verify(() => writer.writeByte(4)).called(1);
      verify(() => writer.write(false)).called(1);
      verify(() => writer.writeByte(5)).called(1);
      verify(() => writer.write(['PS5'])).called(1);
    });

    test(
      'read should construct GameModel from BinaryReader bytes and values',
      () {
        final reader = MockBinaryReader();

        final bytes = [
          6, // numOfFields
          0, // fieldId 0
          1, // fieldId 1
          2, // fieldId 2
          3, // fieldId 3
          4, // fieldId 4
          5, // fieldId 5
        ];
        var byteIdx = 0;
        when(reader.readByte).thenAnswer((_) => bytes[byteIdx++]);

        final values = <dynamic>[
          100, // id
          'Final Fantasy XVII', // name
          null, // coverUrl
          '2028-01-01', // releaseDate
          false, // tba
          <dynamic>['PS5', 'PC'], // platforms
        ];
        var valIdx = 0;
        when(reader.read).thenAnswer((_) => values[valIdx++]);

        final result = adapter.read(reader);

        expect(result.id, 100);
        expect(result.name, 'Final Fantasy XVII');
        expect(result.coverUrl, isNull);
        expect(result.releaseDate, '2028-01-01');
        expect(result.tba, false);
        expect(result.platforms, ['PS5', 'PC']);
      },
    );

    test('equality and hashCode should work based on typeId', () {
      final adapter1 = GameModelAdapter();
      final adapter2 = GameModelAdapter();

      expect(adapter1 == adapter2, isTrue);
      expect(adapter1.hashCode, adapter2.hashCode);
    });
  });
}
