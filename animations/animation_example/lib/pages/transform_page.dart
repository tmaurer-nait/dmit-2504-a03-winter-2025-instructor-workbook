import 'package:flutter/material.dart';
import 'package:animation_example/pages/animations_page.dart';

import 'dart:math' as math;

class TransformPage extends StatelessWidget {
  const TransformPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Transform Page')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 60,
          children: [
            // Rotation Transform
            Transform.rotate(
              angle: 135 * math.pi / 180, // Convert from deg to rad
              child: Text('Rotation Only', style: TextStyle(fontSize: 30)),
            ),
            // Scale Transform
            Transform.scale(
              // scale: 1.5, // scale both axes together
              scaleX: 1.5,
              scaleY: 0.5,
              child: Text('Scale Only', style: TextStyle(fontSize: 30)),
            ),
            // Translation Transform
            Transform.translate(
              offset: Offset(
                60,
                -300,
              ), // x and y offset (positive being down right)
              child: Text('Translate Only', style: TextStyle(fontSize: 30)),
            ),
            // Nested Transforms
            // You need to be careful with ordering etc because they impact each other
            Transform.rotate(
              angle: 180 * math.pi / 180,
              child: Transform.scale(
                scale: 0.75,
                child: Transform.translate(
                  offset: Offset(50, 100),
                  child: Text('Rotate, Scale, Translate'),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.play_arrow),
        onPressed: () {
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (context) => AnimationsPage()));
        },
      ),
    );
  }
}
