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
}
