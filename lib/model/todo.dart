class Todo {
  String title;
  String description;
  final String id;
  bool isDone;
  final DateTime createdTime;

  Todo({
    required this.title,
    required this.createdTime,
    this.description = '',
    this.id = '',
    this.isDone = false,
  });
}
