import 'package:flutter/material.dart';

import 'package:geolocator/geolocator.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  // Stores our current position
  Position? _position;

  Future<Position> _determinePosition() async {
    // Handle all our permission checks

    // Tracks whether location services are enabled on this device or not
    bool serviceEnabled;

    // Tracks whether or not this app is allowed location access
    LocationPermission permission;

    // First check if location services are on
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location Services disabled on this device');
    }

    // Check if we already have permission from a previous run
    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      // We don't already have it so ask for it
      permission = await Geolocator.requestPermission();

      // If they deny it after we ask, decide what to do here
      if (permission == LocationPermission.denied) {
        return Future.error('Location Permissions Denied');
      }
    }

    // after asking for permissions if they've permanently denied us throw an error
    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are denied permanently');
    }

    // If no errors are thrown by now, we have permission
    return await Geolocator.getCurrentPosition(
      locationSettings: LocationSettings(accuracy: LocationAccuracy.best),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Location: ${_position ?? 'unknown'}'),
              ElevatedButton(
                onPressed: () async {
                  final location = await _determinePosition();
                  setState(() {
                    _position = location;
                  });
                },
                child: Text('Get Current Location'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
