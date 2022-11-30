import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/widgets/todo_form_widget.dart';

import '../Utils/utils.dart';
import '../provider/todo_provider.dart';

class EditPage extends StatefulWidget {
  static const String routeName = '/edit-page';
  String? title;
  String? description;

  EditPage({super.key});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final formKey = GlobalKey<FormState>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final routeArg =
        ModalRoute.of(context)?.settings.arguments as Map<dynamic, dynamic>;
    final argTitle = routeArg['title'];
    final argDescription = routeArg['desc'];
    widget.title = argTitle;
    widget.description = argDescription;
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TodoProvider>(context, listen: false);
    final routeArg =
        ModalRoute.of(context)?.settings.arguments as Map<dynamic, dynamic>;
    final argTodo = routeArg['todo'];

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
            title: widget.title.toString(),
            description: widget.description.toString(),
            onChangedDescription: (String value) {
              setState(() {
                widget.description = value;
              });
            },
            onChangedTitle: (String value) {
              setState(() {
                widget.title = value;
              });
            },
            onPressed: () {
              final isValid = formKey.currentState?.validate();

              if (!isValid!) {
                return;
              } else {
                final provider =
                    Provider.of<TodoProvider>(context, listen: false);
                provider.updateTodo(argTodo, widget.title.toString(),
                    widget.description.toString());
              }
              Navigator.of(context).pop();
            },
          ),
        ),
      ),
    );
  }
}
