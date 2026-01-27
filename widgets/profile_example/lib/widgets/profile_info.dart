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
            style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 20,
              fontFamily: 'DynaPuff',
            ),
          ),
        ),
        Text(value, style: TextStyle(fontSize: 20)),
      ],
    );
  }
}
