import 'package:flutter/material.dart';
import 'package:navigation_example/pages/page_two.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('PAGE ONE'),
            ElevatedButton(
              onPressed: () {
                // When I press this button I want to route to page two
                // We'll start with manual route pushing for demonstration
                // But it's usually better to use pushNamed with centralized routing
                Navigator.of(
                  context,
                ).push(MaterialPageRoute(builder: (context) => PageTwo()));
              },
              child: Text('Go To Page Two'),
            ),
            Text('Data from page two goes here'),
          ],
        ),
      ),
    );
  }
}
