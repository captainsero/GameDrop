import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gamedrop/features/games/presentation/widgets/search_hint_view.dart';

void main() {
  testWidgets('SearchHintView displays search icon and instruction text', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SearchHintView(),
        ),
      ),
    );

    expect(find.text('Type a game name and press search'), findsOneWidget);
    expect(find.byIcon(Icons.search), findsOneWidget);
  });
}
