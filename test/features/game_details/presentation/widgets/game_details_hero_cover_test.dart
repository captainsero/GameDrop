import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gamedrop/features/game_details/presentation/widgets/game_details_hero_cover.dart';

void main() {
  testWidgets(
    'GameDetailsHeroCover displays placeholder when coverUrl is null',
    (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: GameDetailsHeroCover(),
          ),
        ),
      );

      expect(find.byIcon(Icons.sports_esports_outlined), findsOneWidget);
    },
  );
}
