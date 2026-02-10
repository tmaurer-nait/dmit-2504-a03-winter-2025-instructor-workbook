import 'package:flutter/material.dart';
import 'package:nested_nav/pages/settings/option_1.dart';
import 'package:nested_nav/pages/settings/option_2.dart';
import 'package:nested_nav/pages/settings/option_3.dart';
import 'package:nested_nav/pages/settings/settings_home.dart';

// This widget's entire purpose is to act as a container for our subnavigator
// and link between the top level navigator and the subnavigator
class SettingsManager extends StatefulWidget {
  final String initialRoute;

  const SettingsManager({super.key, required this.initialRoute});

  @override
  State<SettingsManager> createState() => _SettingsManagerState();
}

class _SettingsManagerState extends State<SettingsManager> {
  // This key will directly reference the sub-navigator so that we can access it
  // from a parent/sibling where Navigator.of(context) would find the top-level one
  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('app settings'),
        leading: IconButton(
          onPressed: () {
            // This is where I will override the default back behaviour to check
            // which stack should be popped
            // First we check if there is a page on the sub-nav stack
            if (_navigatorKey.currentState!.canPop()) {
              // If there is a page to pop, pop it
              _navigatorKey.currentState!.pop();
            } else {
              // If there isn't, pop from the main navigator to go back there
              Navigator.of(context).pop();
            }
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      // This is the sub-navigator that controls navigation between settings pages
      body: Navigator(
        // Provide direct access to this widget
        key: _navigatorKey,
        // Passing through an initial route from our constructor
        initialRoute: widget.initialRoute,
        // Again we will use onGenerateRoute here
        onGenerateRoute: (settings) {
          late Widget page;

          switch (settings.name) {
            case '/':
              page = SettingsHomePage();
              break;
            case '/option-1':
              page = Option1Page();
              break;
            case '/option-2':
              page = Option2Page();
              break;
            case '/option-3':
              page = Option3Page();
              break;
            default:
              throw Exception('Unknown Route Used');
          }

          return MaterialPageRoute(builder: (context) => page);
        },
      ),
    );
  }
}
