import 'package:change_notifier_example/models/user.dart';
import 'package:flutter/material.dart';

class FirstNamePage extends StatelessWidget {
  const FirstNamePage({required this.user, super.key});

  // This should reference the app state that gets passed in from home page
  final User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('First Name Page')),
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: 24.0),
            // The listenable builder widget calls the builder whenever
            // the listenable changes, thereby redrawing the UI in response
            ListenableBuilder(
              listenable: user, // whenever the user (app state) changes, redraw
              builder: (context, child) {
                return Text('Username: ${user.firstName} ${user.lastName}');
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        // Update our user first name here
        onPressed: () {
          user.firstName = 'George';
        },
        child: const Icon(Icons.update),
      ),
    );
  }
}
