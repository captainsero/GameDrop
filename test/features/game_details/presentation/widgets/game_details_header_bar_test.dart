import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gamedrop/features/game_details/presentation/widgets/game_details_header_bar.dart';

void main() {
  testWidgets('GameDetailsHeaderBar displays back button and category', (
    tester,
  ) async {
    var backTapped = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: GameDetailsHeaderBar(
            category: 'ACTION RPG',
            onBack: () => backTapped = true,
          ),
        ),
      ),
    );

    expect(find.text('Back'), findsOneWidget);
    expect(find.text('ACTION RPG'), findsOneWidget);
    expect(find.byIcon(Icons.arrow_back_ios_new_rounded), findsOneWidget);

    await tester.tap(find.text('Back'));
    await tester.pump();

    expect(backTapped, isTrue);
  });
}
