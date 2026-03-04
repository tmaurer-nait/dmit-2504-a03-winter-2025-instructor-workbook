import 'package:flutter/material.dart';
import 'package:inherited_notifier_example/models/user.dart';

class UserNotifier extends InheritedNotifier<User> {
  // We tell the inherited notifier super class, that it should use the User
  // as the change notifier it "inherits"
  const UserNotifier({super.key, required super.child, required User user})
    : super(notifier: user);

  // Finds the most recent UserNotifier ancestor in the tree
  static UserNotifier? maybeOf(BuildContext context) {
    // searches through the build context for the most recent UserNotifier
    return context.dependOnInheritedWidgetOfExactType<UserNotifier>();
  }

  // This method is accessible without ever instantiating UserNotifier
  // Finds the most recent ancestor of type UserNotifier in the widget tree
  // and returns it's user
  static User of(BuildContext context) {
    // First check if UserNotifier is actually in the tree
    final result = maybeOf(context);

    // If not throw error
    if (result == null || result.notifier == null) {
      throw StateError('No UserNotifier found in the tree');
    }

    // If yes return the User (state of the inherited notifier)
    return result.notifier!;
  }
}
