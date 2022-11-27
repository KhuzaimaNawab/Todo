import 'package:flutter/material.dart';

import '../widgets/add_todo_dialog_widget.dart';
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
      TodoList(),
      Container(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo App'),
      ),
      body: tabs[_selectedIndex],
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
            barrierDismissible: false,
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
