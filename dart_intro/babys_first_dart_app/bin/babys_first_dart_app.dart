import 'dart:io';

import 'package:babys_first_dart_app/prompt_helpers.dart';

void main(List<String> arguments) {
  var name = promptForName();
  var gpa = promptForDouble('What is your GPA?');
  stdout.writeln('Hey $name, congrats on your $gpa GPA!!!');
}
