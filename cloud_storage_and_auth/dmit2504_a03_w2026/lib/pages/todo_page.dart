import 'package:flutter/material.dart';
import 'package:dmit2504_a03_w2026/models/todo.dart';
import 'package:dmit2504_a03_w2026/state/application_state.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({required this.appState, super.key});

  final ApplicationState appState;

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  List<Todo> _todoList = [];

  @override
  void initState() {
    super.initState();

    // When we access this page, copy in the todos from the app state
    // They'll already be loaded in from firestore
    setState(() {
      _todoList = widget.appState.todos;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView.builder(
          // This iterates up to itemcount, adding the returned widget to the screen
          itemBuilder: (context, index) {
            final todo = _todoList[index];
            return Dismissible(
              key: UniqueKey(),
              child: ListTile(
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
              ),
              onDismissed: (direction) {
                // Direction is either left or right (in our case it doesn't matter)
                setState(() {
                  // Update frontend
                  _todoList.removeAt(index);
                });
                // TODO: Update the backend
              },
            );
          },
          itemCount: _todoList.length,
        ),
      ),
    );
  }
}
