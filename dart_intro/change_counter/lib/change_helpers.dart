import 'dart:io';

// Returns a List of coin coints ordered by face-value (p,n,d,q,l,t)
List<int> promptForChange() {
  // Initialize variables
  List<int> output = [];
  var coinTypes = [
    'pennies',
    'nickesl',
    'dimes',
    'quarters',
    'loonies',
    'toonies',
  ];

  // for (int i = 0; i < coinTypes.length; i++){

  // }
  // For each coin type
  for (var coinType in coinTypes) {
    // Prompt the user for coin counts
    stdout.writeln('How many $coinType do you have?');
    var input = stdin.readLineSync();
    // Validate that it is an int
    late int count;
    try {
      count = int.parse(input!);
    } catch (e) {
      throw Exception('User did not enter an integer');
    }
    // Validate that it is positive
    if (count < 0) {
      throw Exception('User entered a negative integer');
    }
    // Add to output array
    output.add(count);
  }

  // Return output array
  return output;
}

// Return the total number of cents, given an array of coin counts
int getTotal(List<int> coinCounts) {
  var total = 0;

  // COOL HASHMAP OPTION
  // var counts = {1: 2, 5: 2, 10: 4, 25: 8, 100: 1, 200: 0};

  // for (var key in counts.keys){
  //   total += counts[key]! * key;
  // }

  total += coinCounts[0];
  total += coinCounts[1] * 5;
  total += coinCounts[2] * 10;
  total += coinCounts[3] * 25;
  total += coinCounts[4] * 100;
  total += coinCounts[5] * 200;

  return total;
}
