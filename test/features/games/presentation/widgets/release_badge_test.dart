import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gamedrop/features/games/domain/entities/game_entity.dart';
import 'package:gamedrop/features/games/presentation/widgets/release_badge.dart';

void main() {
  Widget buildTestableWidget(Widget child) {
    return MaterialApp(
      home: Scaffold(
        body: Center(child: child),
      ),
    );
  }

  group('ReleaseBadge', () {
    testWidgets('displays TBA when tba is true', (tester) async {
      const game = GameEntity(
        id: 1,
        name: 'Half-Life 3',
        coverUrl: null,
        releaseDate: null,
        tba: true,
        platforms: ['PC'],
      );

      await tester.pumpWidget(
        buildTestableWidget(const ReleaseBadge(game: game)),
      );

      expect(find.text('TBA'), findsOneWidget);
    });

    testWidgets('displays OUT NOW when releaseDate is today or in the past', (
      tester,
    ) async {
      final game = GameEntity(
        id: 2,
        name: 'Released Title',
        coverUrl: null,
        releaseDate: DateTime.now().subtract(const Duration(days: 1)),
        tba: false,
        platforms: ['PC'],
      );

      await tester.pumpWidget(buildTestableWidget(ReleaseBadge(game: game)));

      expect(find.text('OUT\nNOW'), findsOneWidget);
    });

    testWidgets('displays DAYS remaining when releaseDate is in the future', (
      tester,
    ) async {
      final game = GameEntity(
        id: 3,
        name: 'Future Title',
        coverUrl: null,
        releaseDate: DateTime.now().add(const Duration(days: 20)),
        tba: false,
        platforms: ['PC'],
      );

      await tester.pumpWidget(buildTestableWidget(ReleaseBadge(game: game)));

      expect(find.textContaining('DAYS'), findsOneWidget);
    });
  });
}
