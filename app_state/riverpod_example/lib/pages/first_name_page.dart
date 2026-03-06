import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_example/models/user.dart';

// We replace stateless widget with consumer widget to access our providers
class FirstNamePage extends ConsumerWidget {
  const FirstNamePage({super.key});

  @override
  // The build method now needs a new parameter (ref), which is a reference to our providers
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the ref for changes to the user provider (app state)
    // This is doing lazy initialization - we initialize it the first time we request the userProvider
    // anywhere in our app. After that we just access the current value
    final user = ref.watch(userProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('First Name Page')),
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: 24.0),
            Text('User name: ${user.firstName} ${user.lastName}'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        // Update our user firs name here
        onPressed: () {
          // We already have a reference to the user above that we could just use
          // but for demo purposes here's how you access a provider one time
          final currentUser = ref.read(userProvider);
          // Here's how I update the state
          ref.read(userProvider.notifier).state = User(
            'Micycle',
            currentUser.lastName,
          );
        },
        child: const Icon(Icons.update),
      ),
    );
  }
}
