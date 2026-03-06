import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_example/state/user_cubit.dart';
import 'package:bloc_example/models/user.dart';

class FirstNamePage extends StatelessWidget {
  const FirstNamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('First Name Page')),
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: 24.0),
            // bloc builder works similarly to listenable builder
            // whenever the cubit/bloc that it listens to emits a new state
            // it calls the builder parameter with that new state and draws the returned widget
            // needs the subtypes of the cubit/bloc it listens to and the state that cubit/bloc emits
            BlocBuilder<UserCubit, UserState>(
              builder: (context, state) {
                return Text(
                  'Username: ${state.user.firstName} ${state.user.lastName}',
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        // Update our user firs name here
        onPressed: () {
          // get the user cubit from bloc provider (using inherited widget syntax)
          final cubit = BlocProvider.of<UserCubit>(context);

          // create the new user (to be emitted as a new state)
          final newUser = User('Phineas', cubit.state.user.lastName);

          // emit the new user state by calling updateUser
          cubit.updateUser(newUser);
        },
        child: const Icon(Icons.update),
      ),
    );
  }
}
