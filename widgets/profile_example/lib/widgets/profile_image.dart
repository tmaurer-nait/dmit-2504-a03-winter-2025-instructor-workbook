import 'package:flutter/material.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ClipOval(
          child: Image(
            image: AssetImage('assets/images/patrick_star.png'),
            height: 250,
            width: 250,
          ),
        ),
        Text(
          'Patrick Star',
          style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
