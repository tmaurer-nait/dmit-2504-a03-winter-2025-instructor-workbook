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
  late final Animation _animation;

  var _endVal = 6.0;

  @override
  void initState() {
    super.initState();

    // Create the controller, link to this widgets ticker, and set the duration
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 6),
    );
    _controller.repeat();

    // drive my curved animation off of the controller
    _animation = _controller.drive(CurveTween(curve: Curves.easeInCubic));
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
          spacing: 100,
          children: [
            // Explicit animation using basic controller
            AnimatedBuilder(
              // any time this controller changes, call the builder
              animation: _controller,
              builder: (context, child) {
                return Transform.rotate(
                  angle: _controller.value * 2 * math.pi,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text('Button'),
                  ),
                );
              },
            ),
            // Tween doesn't need a controller/animation
            // it needs a tween and a duration
            TweenAnimationBuilder(
              // By default these run once, to get it to run again change the end value
              tween: Tween<double>(begin: 1, end: _endVal),
              duration: Duration(seconds: 3),
              // Value is effectively like controller.value
              // It's the current value of the tween
              builder: (context, value, widget) {
                return Transform.scale(
                  scale: value,
                  child: Transform.rotate(
                    angle: value * math.pi,
                    child: Text('Scale and rotate'),
                  ),
                );
              },
              onEnd: () => setState(() {
                _endVal = _endVal == 1 ? 6.0 : 1;
              }),
            ),
            // Drive this off a curved animation
            AnimatedBuilder(
              // any time this controller changes, call the builder
              animation: _animation,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, -_animation.value * 400),
                  child: Text(
                    'translating',
                    style: TextStyle(fontSize: 30.0 * _animation.value),
                  ),
                );
              },
            ),
            // Implicit animation
            RotationTransition(
              turns: _controller,
              child: Text("Implicit rotation"),
            ),
            FadeTransition(opacity: _controller, child: Text('Fading')),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Stopping and starting animations
          if (_controller.isAnimating) {
            _controller.stop();
          } else {
            _controller.repeat();
          }
        },
      ),
    );
  }
}
