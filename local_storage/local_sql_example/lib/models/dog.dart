// Simple model class with 3 attributes and a generative constructor
class Dog {
  // If the DB handles generating ids instead of us, this id needs to be nullable
  final int id;
  final String name;
  final int age;

  const Dog({required this.id, required this.age, required this.name});
}
