import 'package:flutter/material.dart';
import 'package:profile_example/widgets/profile_image.dart';
import 'package:profile_example/widgets/profile_info.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  Widget _buildInfoSection() {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          ProfileInfo(label: 'Role', value: 'Dancer'),
          ProfileInfo(label: 'Team', value: 'MJ Backup Dancers'),
          ProfileInfo(label: 'Handle', value: '@PatrickIsAStar'),
          ProfileInfo(label: 'Supervisor', value: 'The King of Pop'),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile Layout Example')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Employee Profile',
              style: TextStyle(fontSize: 36.0, fontWeight: FontWeight.bold),
            ),
            ProfileImage(),
            _buildInfoSection(),
          ],
        ),
      ),
    );
  }
}
