import 'package:flutter/material.dart';

import '../api/firebase_api.dart';
import '../model/todo.dart';

class TodoProvider extends ChangeNotifier {
  List<Todo> _todos = [];

  List<Todo> get todos => _todos.where((todo) => todo.isDone == false).toList();

  List<Todo> get todosCompleted =>
      _todos.where((todo) => todo.isDone == true).toList();

  void setTodo(List<Todo> todo) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _todos = todo;
      notifyListeners();
    });
  }

  void addTodo(Todo todo) {
    FirebaseApi.createTodo(todo);
  }

  void removeTodo(Todo todo) {
    FirebaseApi.deleteTodo(todo);
    notifyListeners();
  }

  void updateTodo(Todo todo, String title, String description) {
    todo.title = title;
    todo.description = description;

    FirebaseApi.updateTodo(todo);
  }

  bool toggleCheckbox(Todo todo) {
    todo.isDone = !todo.isDone;
    FirebaseApi.updateTodo(todo);
    return todo.isDone;
  }
}
