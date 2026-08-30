import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gamedrop/features/game_details/presentation/widgets/game_details_loading_view.dart';

void main() {
  testWidgets('GameDetailsLoadingView renders animated skeleton elements', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: GameDetailsLoadingView(),
        ),
      ),
    );

    expect(find.byType(GameDetailsLoadingView), findsOneWidget);
    expect(find.byType(AnimatedBuilder), findsWidgets);
  });
}
