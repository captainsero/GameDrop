import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gamedrop/features/game_details/presentation/widgets/game_details_about_section.dart';

void main() {
  testWidgets(
    'GameDetailsAboutSection displays ABOUT label and summary content',
    (
      tester,
    ) async {
      const summary =
          'A rogue signal from beyond the solar system triggers a catastrophic eclipse event.';

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: GameDetailsAboutSection(summary: summary),
          ),
        ),
      );

      expect(find.text('ABOUT'), findsOneWidget);
      expect(find.text(summary), findsOneWidget);
    },
  );
}
