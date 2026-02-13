import 'package:flutter/material.dart';
import 'package:local_sql_example/models/dog.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  List<Dog> dogs = [
    Dog(id: 1, name: 'Mocha', age: 17),
    Dog(id: 2, name: 'Jersey', age: 5),
    Dog(id: 3, name: 'Axel', age: 11),
    Dog(id: 4, name: 'Ember', age: 9),
    Dog(id: 4, name: 'Frankie', age: 7),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ListView.separated(
          // ItemBuilder and SeparatorBuilder are builder functions that take in a
          // buildcontext and return a widget. They also take in the index of the current item
          itemBuilder: (context, idx) {
            // Get the dog for the current idx
            final dog = dogs[idx];
            // Display a list tile for that dog
            return ListTile(title: Text('${dog.name} - ${dog.age} years old'));
          },
          // If parameters are not needed in the function body but are required for function
          // signature matching, you can use underscores for them. This marks them as "ignorable"
          separatorBuilder: (_, _) => Divider(),
          // Calls the builder functions once per itemCount
          itemCount: dogs.length,
        ),
      ),
    );
  }
}
