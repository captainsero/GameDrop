import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gamedrop/features/games/presentation/widgets/error_view.dart';

void main() {
  testWidgets(
    'ErrorView displays message and triggers onRetry callback when button tapped',
    (tester) async {
      var retryCalled = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ErrorView(
              message: 'Network connection failed',
              onRetry: () {
                retryCalled = true;
              },
            ),
          ),
        ),
      );

      expect(find.text('Something went wrong'), findsOneWidget);
      expect(find.text('Network connection failed'), findsOneWidget);
      expect(find.byIcon(Icons.wifi_off_rounded), findsOneWidget);

      await tester.tap(find.text('Try Again'));
      await tester.pump();

      expect(retryCalled, isTrue);
    },
  );
}
