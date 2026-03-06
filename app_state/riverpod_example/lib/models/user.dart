// flutter pub add flutter_riverpod
import 'package:flutter_riverpod/legacy.dart';

class User {
  User(String firstName, String lastName) {
    _firstName = firstName;
    _lastName = lastName;
  }

  late final String _firstName;
  late final String _lastName;

  String get firstName => _firstName;
  String get lastName => _lastName;

  // I remove the setters to make this class immutable
  // It can never be changed, it is generally good practice to make your
  // states immutable, it makes it more traceable and testable
}

// Here we create a user provider that "provides" state to the entire application.
// In our case the state is the User class as noted in the subtype <User>.
// Riverpod has many different providers, we use Stateprovider because it's simple
final userProvider = StateProvider<User>(
  // When initialized we call this function to create the first state
  (ref) => User('Jimothy', 'Anderson'),
);
