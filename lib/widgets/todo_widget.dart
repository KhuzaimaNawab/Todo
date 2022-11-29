import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/model/todo.dart';

import '../Utils/utils.dart';
import '../provider/todo_provider.dart';
import '../screens/edit_page.dart';

class TodoWidget extends StatelessWidget {
  final Todo todo;
  const TodoWidget({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Slidable(
        key: Key(todo.id),
        startActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {
                final provider =
                    Provider.of<TodoProvider>(context, listen: false);
                provider.removeTodo(todo);
                Util.showSnackbar(context, "Deleted the task");
              },
              backgroundColor: const Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {
                Navigator.of(context).pushNamed(
                  EditPage.routeName,
                  arguments: {'title': todo.title,'desc': todo.description, 'todo':todo},
                );
              },
              backgroundColor: const Color(0xFF7BC043),
              foregroundColor: Colors.white,
              icon: Icons.edit,
              label: 'Edit',
            ),
          ],
        ),
        child: Container(
          color: Colors.white,
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Checkbox(
                activeColor: Theme.of(context).primaryColor,
                checkColor: Colors.white,
                value: todo.isDone,
                onChanged: (_) {
                  final provider =
                      Provider.of<TodoProvider>(context, listen: false);
                  provider.toggleCheckbox(todo);
                  Util.showSnackbar(context,
                      todo.isDone ? 'Task Completed' : 'Task Mark incomplete');
                },
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      todo.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                        fontSize: 22,
                      ),
                    ),
                    if (todo.description.isNotEmpty)
                      Container(
                        margin: const EdgeInsets.only(top: 4),
                        child: Text(
                          todo.description,
                          style: const TextStyle(
                            fontSize: 20,
                            height: 1.5,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}