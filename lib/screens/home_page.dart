import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/api/firebase_api.dart';
import 'package:todo_app/provider/todo_provider.dart';

import '../widgets/add_todo_dialog_widget.dart';
import '../widgets/completed_task_list.dart';
import '../widgets/todo_list_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final tabs = [
      const TodoList(),
      const CompletedTaskList(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo App'),
      ),
      body: StreamBuilder(
        stream: FirebaseApi.readTodo(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final todo = snapshot.data;
            final provider = Provider.of<TodoProvider>(context);
            provider.setTodo(todo!);
            return tabs[_selectedIndex];
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white.withOpacity(0.7),
        selectedItemColor: Colors.white,
        onTap: (value) => setState(() {
          _selectedIndex = value;
        }),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.fact_check_outlined),
            label: 'Todos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check),
            label: 'Completed',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) => const AddTodoDialogWidget(),
          );
        },
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
