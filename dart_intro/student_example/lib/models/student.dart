class Student {
  // Properties
  late String _firstName;
  late String _lastName;
  late int _idNumber;

  // Constructors
  // fName and lName are required now, id defaults to 0 if not provided
  Student({required String fName, required String lName, int id = 0}) {
    firstName = fName;
    lastName = lName;
    idNumber = id;
  }

  Student.emptyStudent() {
    _firstName = '';
    _lastName = '';
    _idNumber = -1;
  }

  // Getters/Setters
  // String get firstName {
  //   return _firstName;
  // }
  String get firstName => _firstName;

  set firstName(String value) {
    if (value.trim().isEmpty) {
      throw Exception('First Name cannot be empty');
    }

    _firstName = value;
  }

  String get lastName => _lastName;

  set lastName(String value) {
    if (value.trim().isEmpty) {
      throw Exception('Last Name cannot be empty');
    }

    _lastName = value;
  }

  int get idNumber => _idNumber;

  set idNumber(int value) {
    if (value < 0) {
      throw Exception('Id cannot be negative');
    }

    _idNumber = value;
  }

  // Methods
  String getFullName() {
    return '$_firstName $_lastName';
  }

  void incrementId() {
    _idNumber++;
  }

  @override
  String toString() {
    return '${getFullName()} : $_idNumber';
  }
}
