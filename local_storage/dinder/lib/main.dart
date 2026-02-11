import 'package:flutter/material.dart';
import 'package:dinder/widgets/dog_image.dart';

// flutter pub add shared_preferences
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  // This variable will track whether or not we are in dark mode
  var _isDarkMode = false;

  // Create a helper function that reads the dark mode
  // setting from shared preferences
  Future<bool> _readDarkModeFromSharedPrefs() async {
    // First we have to get a reference to the shared prefs instance
    final prefs = await SharedPreferences.getInstance();

    // Secondly read and return the bool for the correct key (with null safety)
    return prefs.getBool('isDarkTheme') ?? false;
  }

  // Initialize the state by checking shared prefs
  @override
  void initState() {
    super.initState();
    _readDarkModeFromSharedPrefs().then((darkMode) {
      setState(() {
        _isDarkMode = darkMode;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // Update the material app to change theme based on dark mode var
    // add a toggle switch to change the dark mode var
    return MaterialApp(
      theme: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(title: Text('Dinder')),
        body: Center(
          child: Column(
            children: [
              DogImage(endpoint: 'https://dog.ceo/api/breeds/image/random'),
              SwitchListTile(
                value: _isDarkMode,
                onChanged: (value) async {
                  setState(() {
                    _isDarkMode = value;
                  });
                  // save to shared prefs
                  final prefs = await SharedPreferences.getInstance();
                  prefs.setBool('isDarkTheme', value);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
