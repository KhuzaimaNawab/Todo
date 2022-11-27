import 'package:flutter/material.dart';

import '../modal/todo.dart';
import 'todo_widget.dart';

class TodoList extends StatelessWidget {
  const TodoList({super.key});

  @override
  Widget build(BuildContext context) {
    return TodoWidget(todo: Todo(
      createdTime: DateTime.now(),
      title: 'Walk the Dog 🐕',
    ),
      
    );
  }
}
