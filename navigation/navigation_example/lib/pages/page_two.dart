import 'package:flutter/material.dart';

class PageTwo extends StatelessWidget {
  const PageTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('PAGE TWO'),
            FilledButton(
              onPressed: () {
                // To return to page one from page two we just pop() the stack
                // This is effectively a back button
                // We can return data by passing it as an argument to pop
                Navigator.of(
                  context,
                ).pop('You left page two via the custom button');
              },
              child: Text('Go back to page one'),
            ),
          ],
        ),
      ),
    );
  }
}
