import 'package:flutter/material.dart';
import 'package:profile_example/pages/profile_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final lightTheme = ThemeData(
      fontFamily: 'DynaPuff',
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: Colors.blue,
        cardColor: Colors.teal,
      ),
    );

    final darkTheme = lightTheme.copyWith(primaryColor: Colors.red);

    return MaterialApp(
      home: ProfilePage(),
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.dark,
    );
  }
}
