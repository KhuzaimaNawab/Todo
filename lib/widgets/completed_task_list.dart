import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/widgets/todo_widget.dart';

import '../provider/todo_provider.dart';

class CompletedTaskList extends StatelessWidget {
  const CompletedTaskList({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TodoProvider>(context);
    final todos = provider.todosCompleted;

    return todos.isEmpty
        ? const Center(
            child: Text('No Completed todos'),
          )
        : ListView.separated(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(16),
            itemBuilder: (context, index) {
              final todo = todos[index];
              return TodoWidget(todo: todo);
            },
            separatorBuilder: (context, index) => Container(
                  height: 8,
                ),
            itemCount: todos.length);
  }
}