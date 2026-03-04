import 'package:flutter/material.dart';
import 'package:inherited_notifier_example/models/user.dart';

import 'pages/home_page.dart';

import 'package:inherited_notifier_example/state/user_notifier.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return UserNotifier(
      user: User('Gregory', 'Tylenol'),
      child: MaterialApp(
        home: Scaffold(body: Center(child: HomePage())),
      ),
    );
  }
}
