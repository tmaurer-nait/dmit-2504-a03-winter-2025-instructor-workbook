import 'package:dmit2504_a03_w2026/pages/home_page.dart';
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
        '/sign-in': (context) => SignInScreen(),
        '/profile': (context) => ProfileScreen(),
      },
    );
  }
}
