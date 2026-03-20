// import our framework
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
// flutter pub add "dev:integration_test:{sdk: flutter}"
import 'package:integration_test/integration_test.dart';

// Import the code to test
import 'package:test_example/main.dart';

void main() {
  // For integration testing we need to do one thing differently than in widget testing
  // We need to ensure that we connect to our integration test framework (and device)
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  // The rest of this looks very similar to our widget tests
  group('end-to-end app tests', () {
    // First test ensures all data is visible

    // When doing tests for e2e testing, it's common practice to write the descriptions as "TODOs" essentially
    testWidgets('start app and ensure all text is visible', (tester) async {
      // unlike in widget tests wer are now loading the entire app
      await tester.pumpWidget(MainApp());

      expect(find.text('Tom'), findsOneWidget);
      expect(find.text('tmaurer@nait.ca'), findsOneWidget);
      expect(find.text('Welcome to the home page'), findsOneWidget);
    });

    // Second test ensures that the toggle works
    testWidgets('Tap on the button and verify the info toggles off/on', (
      tester,
    ) async {
      await tester.pumpWidget(MainApp());

      // verify the toggling text is visible to start
      expect(find.text('Tom'), findsOneWidget);
      expect(find.text('tmaurer@nait.ca'), findsOneWidget);

      // find and tap on button
      final button = find.byType(ElevatedButton);

      await tester.tap(button);

      await tester.pumpAndSettle();

      // Validate that text is toggled off
      expect(find.text('Tom'), findsNothing);
      expect(find.text('tmaurer@nait.ca'), findsNothing);

      // Tap on button again
      await tester.tap(button);

      await tester.pumpAndSettle();

      // Validate that text is back
      expect(find.text('Tom'), findsOneWidget);
      expect(find.text('tmaurer@nait.ca'), findsOneWidget);
    });
  });
}
