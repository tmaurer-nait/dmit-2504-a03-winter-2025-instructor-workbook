import 'package:flutter/material.dart';

class ProfileInfo extends StatelessWidget {
  final String label;
  final String value;

  const ProfileInfo({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 8),
          child: Text(
            '$label:',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        Text(value, style: TextStyle(fontSize: 20)),
      ],
    );
  }
}
