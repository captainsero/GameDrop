import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gamedrop/features/game_details/presentation/widgets/countdown_card.dart';

void main() {
  testWidgets('CountdownCard displays value and label text', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: CountdownCard(value: '54', label: 'DAYS'),
        ),
      ),
    );

    expect(find.text('54'), findsOneWidget);
    expect(find.text('DAYS'), findsOneWidget);
  });
}
