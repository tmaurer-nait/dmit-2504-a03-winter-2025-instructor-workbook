import 'package:flutter/material.dart';
import 'pages/page_one.dart';
import 'pages/page_two.dart';
import 'pages/page_three.dart';
import 'widgets/app_nav_bar.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: AppNavBar.routeOne,
      routes: {
        AppNavBar.routeOne: (context) => const PageOne(),
        AppNavBar.routeTwo: (context) => const PageTwo(),
        AppNavBar.routeThree: (context) => const PageThree(),
      },
    );
  }
}
