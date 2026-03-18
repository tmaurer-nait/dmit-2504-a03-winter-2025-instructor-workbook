// Import your test framework
import 'package:flutter_test/flutter_test.dart';

// Import the code you want to test
import 'package:test_example/models/user.dart';

// flutter test <PATH_TO_TEST_FILE_OR_FOLDER (test if omitted)> (-r expanded)
// flutter test -r expanded

void main() {
  // A reference to the user model
  // it will get recreated for every test
  late User user;

  // Function that lets me organize my tests
  group('User Model Tests', () {
    // Inside this group I can do setup and write all the tests for user model

    // setUp is called once before every test
    // setUpAll is called once before all tests in the group
    setUp(() {
      // before each test runs I want to reset the user to a fresh one
      user = User(name: 'Bobby', email: 'Fischer@gmail.com');
    });

    // tearDown(), and tearDownAll() are like setup except after

    // test has 2 params, a description and a callback body function
    // generally we write descriptions for tests with verbs like "should"
    test('User should have a readable name and email property', () {
      // expect() <- asserts that arg 1 == arg 2
      expect(user.name, 'Bobby');
      expect(user.email, 'Fischer@gmail.com');
    });

    test('User should override toString correctly', () {
      // Arrange - set up your test things
      final expected = 'Name: Bobby, Email: Fischer@gmail.com';

      // Act - do the thing you are testing
      final actual = user.toString();

      // Assert - check that the output is correct
      expect(actual, expected);
    });
  });
}
