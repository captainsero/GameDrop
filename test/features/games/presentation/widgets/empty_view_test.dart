import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gamedrop/features/games/presentation/widgets/empty_view.dart';

void main() {
  testWidgets('EmptyView displays empty state message and icon', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: EmptyView(),
        ),
      ),
    );

    expect(find.text('No upcoming games found'), findsOneWidget);
    expect(find.byIcon(Icons.videogame_asset_off_outlined), findsOneWidget);
  });
}
