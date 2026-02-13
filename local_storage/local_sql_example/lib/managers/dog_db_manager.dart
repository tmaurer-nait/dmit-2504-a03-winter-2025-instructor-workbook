import 'package:local_sql_example/models/dog.dart';

// flutter pub add sqflite
import 'package:sqflite/sqflite.dart';

// flutter pub add path
import 'package:path/path.dart';

class DogDbManager {
  // Because this is a singleton, we will make the constructor private
  // That way no other class can call it. We have to call it from here
  const DogDbManager._();

  // To make the singleton instance accessible I create a static const that is public
  static const DogDbManager instance = DogDbManager._();

  // Set up the initial variables for the DB:
  static const _dbName = 'a03_dogs.db';
  static const _dbVersion = 1;
  static Database? _database; // Private reference to DB

  // a public getter for the database, that either opens a connection to the DB,
  // or returns the open db if a connection has already been established
  Future<Database> get database async {
    // If a connection is open, return that
    if (_database != null) return _database!;

    // connect to DB and return that
    _database = await _connectToDB();
    return _database!;
  }

  // connects to the DB, opening or creating it as needed
  Future<Database> _connectToDB() async {
    // get the local db file location
    final dbPath = await getDatabasesPath();

    // join the dbPath to the dbName (this is the same as '$dbPath/$_dbName')
    final path = join(dbPath, _dbName);

    // Open the connection the db, creating it if needed
    final db = openDatabase(
      path,
      onCreate: (database, _) {
        database.execute(
          'CREATE TABLE dogs(id INTEGER PRIMARY KEY, name TEXT, age INTEGER)',
        );
      },
      version: _dbVersion,
    );

    return db;
  }

  // Closes the DB connection. It should be called in the dispose of any widget that
  // opens the DB to prevent corruption, and other issues
  void closeDb() async {
    // call our getter to retrieve/open the db
    final db = await database;
    db.close();
  }

  // Get all existing dogs from the db
  Future<List<Dog>> getDogs() async {
    final db = await database;

    // Queries the DB for the dogs table. Returns a List<Map<String,Object?>> but we want List<Dog>
    // So we need to convert it out our model class
    final dogMaps = await db.query('dogs');

    // Option 1: For Loop
    // List<Dog> output = [];
    // for (final dogMap in dogMaps) {
    //   output.add(Dog.fromMap(dogMap));
    // }
    // return output;

    // Option 2: List.generate
    // return List.generate(dogMaps.length, (i) => Dog.fromMap(dogMaps[i]));

    // Option 3: List comprehension
    return [for (final dogMap in dogMaps) Dog.fromMap(dogMap)];
  }

  // Adds a dog to the DB
  Future<void> insertDog(Dog dog) async {
    final db = await database;

    // Takes in the table name to insert to, and a map of column names to values
    await db.insert(
      'dogs',
      dog.toMap(),
      // This parameter determines what to do if the PRIMARY KEYs match. here we choose to replace it with the new dog
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Delete a dog in the DB
  Future<void> deleteDog(int id) async {
    final db = await database;
    // This is really bad form because it opens you up to SQL injection attacks
    // db.delete('dogs', where: 'id = $id');
    // Instead we will sanitize the input using whereArgs. whereArgs is a list where each item goes into the ? of the corresponding idx
    await db.delete('dogs', where: 'id = ?', whereArgs: [id]);
  }

  // TODO: Create updateDog function <- Student Exercise
}
