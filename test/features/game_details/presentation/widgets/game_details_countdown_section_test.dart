import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gamedrop/features/game_details/domain/entities/game_detail_entity.dart';
import 'package:gamedrop/features/game_details/presentation/widgets/game_details_countdown_section.dart';

void main() {
  group('GameDetailsCountdownSection', () {
    testWidgets(
      'displays RELEASING IN label and formatted release date for future release',
      (
        tester,
      ) async {
        final releaseDate = DateTime(2026, 10, 24);
        final game = GameDetailEntity(
          id: 1,
          name: 'Eclipse Protocol',
          coverUrl: null,
          releaseDate: releaseDate,
          tba: false,
          platforms: const ['PS5'],
          summary: 'Sci-fi adventure',
        );

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: GameDetailsCountdownSection(game: game),
            ),
          ),
        );

        expect(find.text('RELEASING IN'), findsOneWidget);
        expect(find.text('RELEASE DATE'), findsOneWidget);
        expect(find.text('DAYS'), findsOneWidget);
        expect(find.text('HRS'), findsOneWidget);
        expect(find.text('MIN'), findsOneWidget);
        expect(find.text('SEC'), findsOneWidget);
      },
    );

    testWidgets('displays -- placeholders and TBA when tba is true', (
      tester,
    ) async {
      const game = GameDetailEntity(
        id: 2,
        name: 'TBA Game',
        coverUrl: null,
        releaseDate: null,
        tba: true,
        platforms: ['PC'],
        summary: 'TBA summary',
      );

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: GameDetailsCountdownSection(game: game),
          ),
        ),
      );

      expect(find.text('RELEASING IN'), findsOneWidget);
      expect(find.text('To Be\nAnnounced'), findsOneWidget);
      expect(find.text('--'), findsNWidgets(4));
    });
  });
}
