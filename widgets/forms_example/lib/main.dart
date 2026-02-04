import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: UserSignupForm(),
        ),
      ),
    );
  }
}

// Extract the form into its own widget so it can be stateful
// Plus this is cleaner code
class UserSignupForm extends StatefulWidget {
  const UserSignupForm({super.key});

  @override
  State<UserSignupForm> createState() => _UserSignupFormState();
}

class _UserSignupFormState extends State<UserSignupForm> {
  // We need a way of referencing our form later on so we can leverage
  // the validate/reset power of the form.

  // Two options for doing that, first is Form.of(context)
  // However this only works if the form is an ancestor of the widget that
  // is looking for it. It's generally less robust than the alternative

  // The alternative is to manually assign the key for our form
  // We generate the key ourselves and pass it into the form

  // Note: this key has a type GlobalKey<FormState>
  // not GlobalKey<_UserSignupFormState>
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'New User Sign Up',
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
          // TextFormField rather than TextField to allow connection to the form
          // widget and leveraging the form validate/reset functionality
          TextFormField(decoration: InputDecoration(label: Text('Username'))),
          TextFormField(
            // Always include the below options on password fields
            // for user experience reasons
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            decoration: InputDecoration(label: Text('Password')),
          ),
          TextFormField(
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            decoration: InputDecoration(label: Text('Confirm Your Password')),
          ),
          FilledButton(onPressed: () {}, child: Text('Sign Up!')),
        ],
      ),
    );
  }
}
