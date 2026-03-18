// import framework
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// import code to test
import 'package:test_example/widgets/user_widget.dart';
import 'package:test_example/models/user.dart';

void main() {
  group('User Widget tests', () {
    late User user;
    late Widget app;

    // In my setup I will render the singular widget that I'm testing into
    // an empty material app and scaffold to prevent errors
    setUp(() {
      user = User(name: 'Walter', email: 'Heisenburg@gmail.com');

      // this app will be rendered headless and isolates the widget I am testing
      app = MaterialApp(
        home: Scaffold(body: UserWidget(user: user)),
      );
    });

    // instead of test() we use testWidgets(). This allows access to a WidgetTester object
    // the tester is essentially a reference to the headless environment with many testing features
    // the callback is now also async so we can wait for renders, interactions, etc.
    testWidgets('UserWidget should display name and email on load', (
      tester,
    ) async {
      // Arrange
      // renders the given widget for a single frame
      await tester.pumpWidget(app);

      // Act
      // in UI testing you often use finders and matchers to verify visuals
      // Finders look for things in the ui, they should be used in "human-like" ways if possible
      final name = find.text('Walter');
      final email = find.text('Heisenburg@gmail.com');
      final button = find.byType(ElevatedButton);

      // Assert
      // our expects can now use matchers with finders to check for a number of
      // matching widgets.
      // there are many kinds of matchers (findsOne, findsAny, findsN, findsNothing)
      expect(name, findsOneWidget);
      expect(email, findsOneWidget);
      expect(button, findsOneWidget);
    });

    testWidgets('User Widget should toggle info when button is pressed', (
      tester,
    ) async {
      await tester.pumpWidget(app);

      final name = find.text('Walter');
      final email = find.text('Heisenburg@gmail.com');
      final button = find.byType(ElevatedButton);

      expect(name, findsOneWidget);
      expect(email, findsOneWidget);
      // ^ Start by ensuring that the visuals are there at the start

      // testers can also be used to interact with widgets
      await tester.tap(button);

      // Once I tap, I need to wait for the handling, setState, rebuild, etc.
      // There are a couple of options
      // await tester.pump(Duration(seconds: 1)); // renders frames for 1 second
      await tester.pumpAndSettle(); // renders frames until none are scheduled

      expect(name, findsNothing);
      expect(email, findsNothing);

      // Toggle back on
      await tester.tap(button);
      await tester.pumpAndSettle();

      expect(name, findsOneWidget);
      expect(email, findsOneWidget);
    });
  });
}
