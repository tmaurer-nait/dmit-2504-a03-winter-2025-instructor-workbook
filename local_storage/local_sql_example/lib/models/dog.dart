// Simple model class with 3 attributes and a generative constructor
class Dog {
  // If the DB handles generating ids instead of us, this id needs to be nullable
  final int id;
  final String name;
  final int age;

  const Dog({required this.id, required this.age, required this.name});

  // This function turns a Map into a Dog
  // The map looks like this (ColumName: value) - {'id': 0, 'age': 5, 'name': 'Rover'}
  factory Dog.fromMap(Map<String, Object?> dogMap) => Dog(
    id: dogMap['id'] as int,
    name: dogMap['name'] as String,
    age: dogMap['age'] as int,
  );

  // This function turns our dog into a Map so that SQL can read it
  Map<String, Object?> toMap() => {'id': id, 'name': name, 'age': age};
}
