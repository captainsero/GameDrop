import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gamedrop/features/games/presentation/widgets/platform_chip.dart';

void main() {
  testWidgets('PlatformChip renders the provided label text', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: PlatformChip(label: 'PlayStation 5'),
        ),
      ),
    );

    expect(find.text('PlayStation 5'), findsOneWidget);
  });
}
