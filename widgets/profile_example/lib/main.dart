import 'package:flutter/material.dart';
import 'package:profile_example/widgets/profile_info.dart';
import 'package:profile_example/widgets/profile_image.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Employee Profile',
                style: TextStyle(fontSize: 36.0, fontWeight: FontWeight.bold),
              ),
              ProfileImage(),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    ProfileInfo(label: 'Role', value: 'Dancer'),
                    ProfileInfo(label: 'Team', value: 'MJ Backup Dancers'),
                    ProfileInfo(label: 'Handle', value: '@PatrickIsAStar'),
                    ProfileInfo(label: 'Supervisor', value: 'The King of Pop'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
