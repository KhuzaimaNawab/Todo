import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/widgets/todo_form_widget.dart';

import '../Utils/utils.dart';
import '../model/todo.dart';
import '../provider/todo_provider.dart';
import '../widgets/todo_widget.dart';

class EditPage extends StatefulWidget {
  static const String routeName = '/edit-page';

  const EditPage({super.key});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final routeArg =
        ModalRoute.of(context)?.settings.arguments as Map<dynamic, dynamic>;
    final argTitle = routeArg['title'];
    final argDescription = routeArg['desc'];
    final argTodo = routeArg['todo'];
    final provider = Provider.of<TodoProvider>(context, listen: false);

    String title = argTitle;
    String description = argDescription;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Todo'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: IconButton(
              onPressed: () {
                provider.removeTodo(argTodo);
                Navigator.of(context).pushNamed('/');
                Util.showSnackbar(context, "Task Deleted");
              },
              icon: const Icon(Icons.delete),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: TodoFormWidget(
            title: title,
            description: description,
            onChangedDescription: (String value) {
              setState(() {
                description = value;
              });
            },
            onChangedTitle: (String value) {
              setState(() {
                title = value;
              });
            },
            onPressed: () {
              final isValid = formKey.currentState?.validate();

              if (!isValid!) {
                return;
              } else {
                final provider =
                    Provider.of<TodoProvider>(context, listen: false);
                print(title);
                provider.updateTodo(argTodo, title, description);
              }
              Navigator.of(context).pop();
            },
          ),
        ),
      ),
    );
  }
}
