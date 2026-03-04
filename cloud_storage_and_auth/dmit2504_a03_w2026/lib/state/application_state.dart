import 'package:flutter/material.dart';
import 'package:dmit2504_a03_w2026/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
// flutter pub add cloud_firestore
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dmit2504_a03_w2026/models/todo.dart';

import 'package:firebase_ui_auth/firebase_ui_auth.dart';
// I hide the EmailAuthProvider to prevent import collisions between
// this and firebase_ui_auth
import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;

// By extending change notifier I can make this class listenable
// Other classes can then listen to changes in this class and respond to them
class ApplicationState extends ChangeNotifier {
  // This class's job is broadcast changes in firebase
  // to the rest of the application
  ApplicationState() {
    init();
  }

  // A simple bool that tracks whether or not a user is logged in
  var _loggedIn = false;
  bool get loggedIn => _loggedIn;

  // We need to track the logged in user, so we can access their specific todos
  User? _user;
  User? get user => _user;
  set user(User? user) {
    if (user == null) {
      throw ArgumentError('User cannot be set to null');
    }
    _user = user;
  }

  // Variable that tracks the current todos for the logged in user
  List<Todo>? _todos;
  List<Todo> get todos {
    if (user == null) {
      throw StateError('Cannot get todos when user is null');
    }
    return _todos ?? [];
  }

  set todos(List<Todo> todos) {
    if (user == null) {
      throw StateError('Cannot set todos when user is null');
    }
    _todos = todos;
  }

  void _fetchTodos() {
    if (user == null) {
      throw StateError('Cannot fetch todos when user is null');
    }

    // Access the firestore instance
    FirebaseFirestore.instance
        // Get the doc/collection of docs
        .collection('/todos/${user!.uid}/todos')
        .get()
        // Update the app state to match
        .then((todoCollection) {
          // Convert the docs to Todo Models
          todos = todoCollection.docs
              .map((doc) => Todo.fromFirestore(doc))
              .toList();
        });
  }

  void updateTodo(Todo todo) {
    // Make sure user is not null
    if (user == null) {
      throw StateError('Cannot update todos when user is null');
    }

    // Access firestore instance
    FirebaseFirestore.instance
        // Access the resource you need
        .collection('/todos/${user!.uid}/todos')
        .doc(todo.id)
        // Replace the values in that document
        .update(todo.toMap());
  }

  void deleteTodo(Todo todo) {
    if (user == null) {
      throw StateError('Cannot delete todos when user is null');
    }

    FirebaseFirestore.instance
        .collection('/todos/${user!.uid}/todos')
        .doc(todo.id)
        .delete()
        .then((_) {
          // Once the delete occurs in the backend update the app state
          todos.remove(todo);
          // In theory here is where we'd notify listeners
        });
  }

  // Initialize connection to firebase, and configure firebase auth settings/listeners
  Future<void> init() async {
    // This connects us to firebase before starting the app
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    // Configure ui auth provider to tell it to allow email auth
    FirebaseUIAuth.configureProviders([EmailAuthProvider()]);

    // Whenever the auth user state changes (login or logout)
    // We will notify all listeners of that change
    FirebaseAuth.instance.userChanges().listen((user) {
      // if the user is logged out user will be null
      if (user == null) {
        _loggedIn = false;
      } else {
        _loggedIn = true;
        // Once they log in, save the user value in the app state
        this.user = user;
        // Then fetch all their todos and store them in the app state
        _fetchTodos();
      }

      // Once we've updated our state variable we notify any listeners
      // of the change.
      // This function is built in to the ChangeNotifier class that we extended
      notifyListeners();
    });
  }
}
