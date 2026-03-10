import 'package:flutter/material.dart';

import 'dart:math' as math;

class AnimationsPage extends StatefulWidget {
  const AnimationsPage({super.key});

  @override
  State<AnimationsPage> createState() => _AnimationsPageState();
}

class _AnimationsPageState extends State<AnimationsPage>
    with SingleTickerProviderStateMixin {
  // Allows us to sync animations with the device frame rate

  // This will drive our animations and provide controll access (stop, start, repeat, etc.)
  // It goes from 0-1 linearly over some duration
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    // Create the controller, link to this widgets ticker, and set the duration
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Animations Page')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 16,
          children: [
            // Explicit animation using basic controller
            AnimatedBuilder(
              // any time this controller changes, call the builder
              animation: _controller,
              builder: (context, child) {
                return Transform.rotate(
                  angle: _controller.value * 2 * math.pi,
                  child: Text('Rotating', style: TextStyle(fontSize: 30)),
                );
              },
            ),
          ],
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
