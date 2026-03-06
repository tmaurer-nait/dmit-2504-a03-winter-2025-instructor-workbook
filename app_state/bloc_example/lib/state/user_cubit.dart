// flutter pub add flutter_bloc
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bloc_example/models/user.dart';

// In theory we could just use our User class as the state - like we did in riverpod
// However imagine a world where we have things like "isLoading", "ErrorMessage", etc.
// In that case we would wrap our User class in a UserState that holds that extra info
class UserState {
  UserState(User user) {
    _user = user;
    // We could add those extra properties to this class
  }

  // again no setter for immutability
  late final User _user;
  User get user => _user;
}

// Create our cubit that will "emit user states" (similar to a stream of user states)
class UserCubit extends Cubit<UserState> {
  // Cubits need 2 things, state and functions that emit new states

  // We initialize the super class state with a default starting value
  UserCubit() : super(UserState(User('Ronald', 'Mcdonald')));

  // public method that emits new user states (replacing the current ones)
  void updateUser(User user) {
    // emit is built in to the cubit class and sends the next state down stream
    return emit(UserState(user));
  }
}
