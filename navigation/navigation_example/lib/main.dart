import 'package:flutter/material.dart';
import 'package:navigation_example/pages/home_page.dart';
import 'package:navigation_example/pages/page_two.dart';
// Utilize constants to prevent typos
import 'package:navigation_example/constants/routes.dart' as routes;

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // The home property determines the first page shown by the app.
      // There is another way to do this with routes as shown below.
      // home: HomePage(),

      // There's also a third way to do routes, we'll discuss this in the future
      // onGenerateRoute:

      // The routes arguments takes in a map of String to builder function
      // We can then use those strings to identify the page we want to route to
      // in the future using pushNamed
      routes: {
        // These strings map to functions that take in a BuildContext and return a Widget
        routes.homeRoute: (context) => HomePage(),
        routes.pageTwoRoute: (context) => PageTwo(),
      },
    );
  }
}
