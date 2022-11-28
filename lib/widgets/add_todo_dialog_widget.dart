import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/provider/todo_provider.dart';
import 'package:todo_app/widgets/todo_form_widget.dart';

import '../model/todo.dart';

class AddTodoDialogWidget extends StatefulWidget {
  const AddTodoDialogWidget({super.key});

  @override
  State<AddTodoDialogWidget> createState() => _AddTodoDialogWidgetState();
}

class _AddTodoDialogWidgetState extends State<AddTodoDialogWidget> {
  final formKey = GlobalKey<FormState>();
  String title = '';
  String description = '';
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: AlertDialog(
        title: const Text('Add Todo'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TodoFormWidget(
              onChangedTitle: (title) {
                setState(() {
                  this.title = title;
                });
              },
              onChangedDescription: (description) {
                setState(() {
                  this.description = description;
                });
              },
              onPressed: () {
                final isValid = formKey.currentState?.validate();

                if (!isValid!) {
                  return;
                } else {
                  final todo = Todo(
                    id: DateTime.now().toString(),
                    title: title,
                    description: description,
                    createdTime: DateTime.now(),
                  );

                  final provider =
                      Provider.of<TodoProvider>(context, listen: false);
                  provider.addTodo(todo);
                }
                Navigator.of(context).pop();
              },
            )
          ],
        ),
      ),
    );
  }
}
