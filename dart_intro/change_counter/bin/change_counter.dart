import 'package:change_counter/change_helpers.dart';

void main(List<String> arguments) {
  var counts = promptForChange();
  var total = getTotal(counts);

  print('Your total is \$${total / 100}');
}
