import 'dart:ffi';

class Todo {
  final String title;
  final String description;
  final String id;
  final bool isDone;
  final DateTime createdTime;

  Todo({
    required this.title,
    required this.createdTime,
    this.description = '',
    this.id= '',
    this.isDone = false,
  });
}
