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
        // Listenable Builder has 2 parameters
        // listenable -> the thing that we listen to changes in
        // builder -> callback builder function that we call whenever the listenable changes
        child: ListenableBuilder(
          listenable: appState,
          builder: (context, _) {
            // Every time the app state changes, check the loggedIn status and
            // render the corresponding button
            return appState.loggedIn
                ? Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed('/profile');
                        },
                        child: Text('Profile Page'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed('/todos');
                        },
                        child: Text('Todo Page'),
                      ),
                    ],
                  )
                : ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('/sign-in');
                    },
                    child: Text('Sign In Page'),
                  );
          },
        ),
      ),
    );
  }
}
