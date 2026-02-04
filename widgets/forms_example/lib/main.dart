import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'New User Sign Up',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              TextField(decoration: InputDecoration(label: Text('Username'))),
              TextField(decoration: InputDecoration(label: Text('Password'))),
              TextField(
                decoration: InputDecoration(
                  label: Text('Confirm Your Password'),
                ),
              ),
              FilledButton(onPressed: () {}, child: Text('Sign Up!')),
            ],
          ),
        ),
      ),
    );
  }
}
