import 'package:inherited_notifier_example/models/user.dart';
import 'package:flutter/material.dart';
import 'package:inherited_notifier_example/state/user_notifier.dart';

class LastNamePage extends StatelessWidget {
  const LastNamePage({super.key});

  @override
  Widget build(BuildContext context) {
    User user = UserNotifier.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Last Name Page')),
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
          user.lastName = 'Bush';
        },
        child: const Icon(Icons.update),
      ),
    );
  }
}
