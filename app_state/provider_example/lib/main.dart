import 'package:flutter/material.dart';
import 'package:provider_example/models/user.dart';

import 'pages/home_page.dart';

import 'package:provider/provider.dart';

void main() {
  // We wrap our entire app in a provider which will "provide"
  // access to our User state object, for any consumers in the tree
  runApp(
    Provider(
      // Here is where I initialize the state
      create: (context) => User('Stewart', 'Dent'),
      // The state is provided to the main app
      child: MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(body: Center(child: HomePage())),
    );
  }
}
