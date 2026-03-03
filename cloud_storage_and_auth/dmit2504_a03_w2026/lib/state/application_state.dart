import 'package:flutter/material.dart';
import 'package:dmit2504_a03_w2026/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

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
      }

      // Once we've updated our state variable we notify any listeners
      // of the change.
      // This function is built in to the ChangeNotifier class that we extended
      notifyListeners();
    });
  }
}
