// When doing TDD I like to stub out the code first
// to prevent syntax errors

class User {
  // two String properties
  late final String name;
  late final String email;

  // Default Constructor
  User({required this.name, required this.email});

  // Override toString 'Name: <name>, Email: <email>'
  @override
  String toString() {
    return 'Name: $name, Email: $email';
  }
}
