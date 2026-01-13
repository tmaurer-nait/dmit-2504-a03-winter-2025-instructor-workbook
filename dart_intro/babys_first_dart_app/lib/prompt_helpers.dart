import 'dart:io';

String promptForName() {
  stdout.writeln('What is your name?');

  var name = stdin.readLineSync();

  return name ?? '';
}

double promptForDouble(String msg) {
  // Prompt the user with the given message
  stdout.writeln(msg);

  var input = stdin.readLineSync();

  late double output;
  var isValid = false;

  while (!isValid) {
    try {
      output = double.parse(input!);
      isValid = true;
    } catch (e) {
      stdout.writeln('Something went wrong. Please enter a number');
      input = stdin.readLineSync();
    }
  }

  return output;
}
