import 'package:flutter/material.dart';

class AnimationsPage extends StatefulWidget {
  const AnimationsPage({super.key});

  @override
  State<AnimationsPage> createState() => _AnimationsPageState();
}

class _AnimationsPageState extends State<AnimationsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Animations Page')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 16,
          children: [],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //NOOP
        },
      ),
    );
  }
}
