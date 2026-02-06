import 'package:flutter/material.dart';
// You don't need to import the page when using a named route
// import 'package:navigation_example/pages/page_two.dart';
import 'package:navigation_example/constants/routes.dart' as routes;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Use this to display the return value from page two
  var data = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('PAGE ONE'),
            ElevatedButton(
              // We made this async so we can "listen" for a response from page two
              // Navigator.push() resolves when the page it pushes is popped from the stack
              onPressed: () async {
                // When I press this button I want to route to page two
                // We'll start with manual route pushing for demonstration
                // But it's usually better to use pushNamed with centralized routing
                // Navigator.of(
                //   context,
                // ).push(MaterialPageRoute(builder: (context) => PageTwo()));

                final returnValue = await Navigator.of(
                  context,
                ).pushNamed(routes.pageTwoRoute);

                setState(() {
                  // We use this null check in case the user pops the page without any data
                  // (by using the built in back buttons instead of our custom buttons)
                  data = returnValue != null ? returnValue as String : '';
                });
              },
              child: Text('Go To Page Two'),
            ),
            Text(data.isEmpty ? "Awaiting Response....." : data),
          ],
        ),
      ),
    );
  }
}
