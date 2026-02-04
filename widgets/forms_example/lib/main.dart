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

  // Create some text editing controllers so we can access the values of our form
  // This is sort of equivalent to const [name, setName] = useState('') in React
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _password2Controller = TextEditingController();

  String? _isPasswordEmpty(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Password Cannot Be Empty';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      // Validate automatically
      autovalidateMode: AutovalidateMode.always,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'New User Sign Up',
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
          // TextFormField rather than TextField to allow connection to the form
          // widget and leveraging the form validate/reset functionality
          TextFormField(
            // Here I bind the individual controller to the form field
            controller: _usernameController,
            validator: (value) => (value == null || value.trim().isEmpty)
                ? 'Username cannot be empty'
                : null,
            decoration: InputDecoration(label: Text('Username')),
          ),
          TextFormField(
            // Always include the below options on password fields
            // for user experience reasons
            controller: _passwordController,
            validator: _isPasswordEmpty,
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            decoration: InputDecoration(label: Text('Password')),
          ),
          TextFormField(
            controller: _password2Controller,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Password Cannot Be Empty';
              }
              if (value != _passwordController.text) {
                return 'Passwords Do Not Match';
              }
              return null;
            },
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            decoration: InputDecoration(label: Text('Confirm Your Password')),
          ),
          FilledButton(
            onPressed: () {
              // For our validation we will leverage the forms validate capability
              // This calls the validator on every single input in the form
              // We will utilize the key we defined above to access the form state
              if (_formKey.currentState!.validate()) {
                // Once we've done the validation we can do something productive
                // with our form data by using the values in the controllers
                // Usually that would be something like calling an API, updating a DB, etc.

                // We are just going to show a toast instead
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      // By putting several strings next to each other I can
                      // split them across multiple lines in editor but have them
                      // as one line in the display
                      'Username: ${_usernameController.text}, '
                      'Password: ${_passwordController.text}, '
                      'Password 2: ${_password2Controller.text}',
                    ),
                  ),
                );

                _formKey.currentState!.reset();
              }
            },
            child: Text('Sign Up!'),
          ),
        ],
      ),
    );
  }
}
