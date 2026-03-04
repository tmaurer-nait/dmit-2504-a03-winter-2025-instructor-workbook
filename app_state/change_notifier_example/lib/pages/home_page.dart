import 'package:change_notifier_example/models/user.dart';
import 'package:flutter/material.dart';

import 'first_name_page.dart';
import 'last_name_page.dart';

class HomePage extends StatelessWidget {
  // Here we create our shared User app state variable
  // The colon syntax allows us to do variable initialization before the
  // constructor body executes (avoiding the late keyword)
  HomePage({super.key}) : user = User('Tom', 'Maurer');

  final User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Page')),
      body: Center(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () => Navigator.of(context).push(
                // Here we pass our app state into the child widget that needs it (FirstNamePage)
                MaterialPageRoute(
                  builder: (context) => FirstNamePage(user: user),
                ),
              ),
              child: const Text('First Name Page'),
            ),
            const SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => LastNamePage(user: user),
                ),
              ),
              child: const Text('Last Name Page'),
            ),
          ],
        ),
      ),
    );
  }
}
