import 'package:flutter/material.dart';
import 'package:local_sql_example/models/dog.dart';
import 'package:local_sql_example/managers/dog_db_manager.dart';

// needed for randomness
import 'dart:math';

void main() {
  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  MainApp({super.key});
  final dogManager = DogDbManager.instance;

  // we need to create a random number generator to use later on
  final rng = Random();
  final randomNameChoices = ['Mocha', 'Jersey', 'Axel', 'Ember', 'Frankie'];

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  List<Dog> dogs = [];
  int lastId = 0;

  void _loadDogs() async {
    try {
      // Get all dogs from the db
      final dbDogs = await widget.dogManager.getDogs();

      // set the state to show those dogs
      setState(() {
        dogs = dbDogs;
        lastId = dbDogs.isNotEmpty ? dbDogs.last.id : 0;
      });
    } catch (e) {
      print(e);
    }
  }

  // Normally we would create the dogs in a real way based off of an api or user input etc. (we're short on time though)
  // instead we'll create this test data function
  void _createTestData() async {
    try {
      for (var i = 0; i < 3; i++) {
        // Get a random name
        final randName =
            widget.randomNameChoices[widget.rng.nextInt(
              widget.randomNameChoices.length - 1,
            )];

        // Create a new dog with next id and random age
        // NOTE: Because we are manually adding IDs instead of using auto-generate in SQL
        // we need to make sure we don't insert at the same id or we will replace the data
        final newDog = Dog(
          name: randName,
          age: widget.rng.nextInt(20),
          id: lastId + i + 1,
        );

        // insert the dog
        await widget.dogManager.insertDog(newDog);
      }
      // after all dogs inserted, refresh the data. (This is OPTION 2 from the notes)
      _loadDogs();
    } catch (e) {
      print(e);
    }
  }

  Future<void> _removeDog(int id) async {
    try {
      // Again this uses option 2 from our notes
      await widget.dogManager.deleteDog(id);
      _loadDogs();
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    _loadDogs();
  }

  @override
  void dispose() {
    super.dispose();
    widget.dogManager.closeDb();
  }

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
            return ListTile(
              title: Text('${dog.name} - ${dog.age} years old'),
              onTap: () {
                _removeDog(dog.id);
              },
            );
          },
          // If parameters are not needed in the function body but are required for function
          // signature matching, you can use underscores for them. This marks them as "ignorable"
          separatorBuilder: (_, _) => Divider(),
          // Calls the builder functions once per itemCount
          itemCount: dogs.length,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _createTestData,
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
