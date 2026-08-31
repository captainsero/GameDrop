import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gamedrop/features/game_details/domain/entities/game_detail_entity.dart';
import 'package:gamedrop/features/game_details/presentation/widgets/game_details_info_section.dart';

void main() {
  const tGame = GameDetailEntity(
    id: 1,
    name: 'Eclipse Protocol',
    coverUrl: null,
    releaseDate: null,
    tba: false,
    platforms: ['PS5', 'Xbox'],
    summary: 'A sci-fi action RPG adventure.',
  );

  testWidgets('GameDetailsInfoSection displays title, platforms and chips', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: GameDetailsInfoSection(game: tGame),
        ),
      ),
    );

    expect(find.text('Eclipse Protocol'), findsOneWidget);
    expect(find.text('PS5 \u00B7 Xbox'), findsOneWidget);
    expect(find.text('PS5'), findsOneWidget);
    expect(find.text('Xbox'), findsOneWidget);
  });
}
