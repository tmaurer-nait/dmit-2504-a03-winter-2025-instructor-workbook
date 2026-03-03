import 'package:dmit2504_a03_w2026/pages/home_page.dart';
import 'package:dmit2504_a03_w2026/pages/todo_page.dart';
import 'package:dmit2504_a03_w2026/state/application_state.dart';
import 'package:flutter/material.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';

void main() {
  // Makes sure our widget binding is ready to go
  WidgetsFlutterBinding.ensureInitialized();

  var appState = ApplicationState();

  runApp(MainApp(applicationState: appState));
}

class MainApp extends StatelessWidget {
  const MainApp({required this.applicationState, super.key});

  final ApplicationState applicationState;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => HomePage(appState: applicationState),
        // The sign in screen from firebase ui auth
        '/sign-in': (context) => SignInScreen(
          // A list of actions (callback functions) that will be bound to sign in functionality
          actions: [
            // The callback is called with the new auth state when it changes
            // (login, sign up, sign out)
            AuthStateChangeAction((context, state) {
              // The auth state has changed, find out what happened and handle it
              // The following is shorthand for variable assignment based on
              // the type of another variable using a switch statement
              final user = switch (state) {
                // User signed in to an existing account
                SignedIn state => state.user,
                // User was just created
                UserCreated state => state.credential.user,
                // Anything else
                _ => null,
              };

              // if user is null do nothing (stay on sign in page)
              if (user == null) return;

              // Type check that a user was just created
              if (state is UserCreated) {
                // New user, username is everything before @ in their email
                user.updateDisplayName(user.email!.split('@').first);
              }

              // If the user was created or they signed in to an existing user
              // navigate to the home page
              // Remove the sign in page from the top of the stack
              Navigator.of(context).pop();
              // Navigate to the home page
              Navigator.of(context).pushReplacementNamed('/');
            }),
          ],
        ),
        // The profile screen from firebase ui auth
        '/profile': (context) => ProfileScreen(
          // add an action just like we did on the sign in screen
          actions: [
            // When there is a sign out call the callback
            // which will route back to home
            SignedOutAction((context) {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed('/');
            }),
          ],
        ),
      },
      // When evaluating route destination there is a priority order
      // 1. home
      // 2. check routes map
      // 3. call on generate route
      onGenerateRoute: (settings) {
        if (settings.name == '/todos') {
          // We want to protect the todos route with a simple auth check using our appstate
          if (applicationState.loggedIn) {
            return MaterialPageRoute(builder: (context) => TodoPage());
          } else {
            // User is not logged in, redirect to the home page
            return MaterialPageRoute(
              builder: (context) => HomePage(appState: applicationState),
            );
          }
        }
        // If route does not exist we should return a 404 here
        return null;
      },
    );
  }
}
