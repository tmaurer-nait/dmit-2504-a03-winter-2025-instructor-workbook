import 'package:flutter/material.dart';
import 'package:dinder/widgets/dog_image.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dinder')),
      body: Center(child: DogImage()),
    );
  }
}
