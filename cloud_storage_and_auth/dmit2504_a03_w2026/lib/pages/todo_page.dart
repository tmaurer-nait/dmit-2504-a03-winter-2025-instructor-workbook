import 'package:flutter/material.dart';
import 'package:dmit2504_a03_w2026/models/todo.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  List<Todo> _todoList = [
    Todo(description: "complete assignment 3", isComplete: true),
    Todo(description: "plan project", isComplete: false),
    Todo(description: "sleep", isComplete: false),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView.builder(
          // This iterates up to itemcount, adding the returned widget to the screen
          itemBuilder: (context, index) {
            final todo = _todoList[index];
            return ListTile(
              title: Text(
                todo.description,
                style: TextStyle(
                  decoration: todo.isComplete
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
              trailing: Checkbox(
                value: todo.isComplete,
                onChanged: (value) {
                  // Update the frontend
                  setState(() {
                    todo.isComplete = value!;
                  });
                  // TODO: Update the backend
                },
              ),
            );
          },
          itemCount: _todoList.length,
        ),
      ),
    );
  }
}
