import 'package:flutter/material.dart';
import 'package:nested_nav/pages/home_page.dart';
import 'package:nested_nav/pages/settings_manager.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // A third option for routing/setting the home page
      // This takes in a RouteSettings and returns a route to go to
      // RouteSettings includes the name of the route and any arguments
      onGenerateRoute: (settings) {
        // We'll use this to store the return page value
        late Widget page;

        // By switching on settings.name we can check the requested route name
        switch (settings.name) {
          // by default we show home page
          case '/':
            page = HomePage();
            break;

          // This case matches any settings.name that starts with
          // '/settings'. This allows us to set up deep links
          case String name when name.startsWith('/settings'):
            // Pass in everything after /settings as the initial route
            page = SettingsManager(initialRoute: settings.name!.substring(9));
            break;
          default:
            // This is where you'd traditionally show a 404 page or something
            throw Exception('Unknown Route Used');
        }

        // After we select the correct page to route to, put it in
        // a material page route and return
        return MaterialPageRoute(builder: (context) => page);
      },
    );
  }
}
