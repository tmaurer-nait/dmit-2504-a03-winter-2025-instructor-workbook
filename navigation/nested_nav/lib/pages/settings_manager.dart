import 'package:flutter/material.dart';
import 'package:nested_nav/pages/settings/settings_home.dart';

// This widget's entire purpose is to act as a container for our subnavigator
// and link between the top level navigator and the subnavigator
class SettingsManager extends StatefulWidget {
  const SettingsManager({super.key});

  @override
  State<SettingsManager> createState() => _SettingsManagerState();
}

class _SettingsManagerState extends State<SettingsManager> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // This is the sub-navigator that controls navigation between settings pages
      body: Navigator(
        // Again we will use onGenerateRoute here
        onGenerateRoute: (settings) {
          late Widget page;

          switch (settings.name) {
            case '/':
              page = SettingsHomePage();

              break;
            default:
          }

          return MaterialPageRoute(builder: (context) => page);
        },
      ),
    );
  }
}
