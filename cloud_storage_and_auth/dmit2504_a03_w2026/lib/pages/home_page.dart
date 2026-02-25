import 'package:flutter/material.dart';
import 'package:dmit2504_a03_w2026/state/application_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({required this.appState, super.key});

  // reference to the overall app state (with the loggedin info)
  final ApplicationState appState;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: appState.loggedIn
            ? ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/profile');
                },
                child: Text('Profile Page'),
              )
            : ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/sign-in');
                },
                child: Text('Sign In Page'),
              ),
      ),
    );
  }
}
