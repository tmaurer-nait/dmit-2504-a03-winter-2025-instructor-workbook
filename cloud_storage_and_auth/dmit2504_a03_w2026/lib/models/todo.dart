import 'package:cloud_firestore/cloud_firestore.dart';

class Todo {
  String description;
  bool isComplete;
  String? id;

  Todo({required this.description, required this.isComplete, this.id});

  // factory constructor to convert from firestore to Todo
  factory Todo.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data();
    return Todo(
      description: data!['description'],
      isComplete: data['isComplete'],
      id: snapshot.id,
    );
  }

  // toMap function for firestore inserts
  Map<String, dynamic> toMap() {
    return {'description': description, 'isComplete': isComplete};
  }
}
