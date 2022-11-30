import 'package:todo_app/Utils/utils.dart';
class TodoField {
  static const createdTime = 'createdTime';
}

class Todo {
  String title;
  String description;
  String id;
  bool isDone;
  final DateTime createdTime;

  Todo({
    required this.title,
    required this.createdTime,
    this.description = '',
    this.id = '',
    this.isDone = false,
  });

  static Todo fromJson(Map<String, dynamic> json) => Todo(
        createdTime: Util.toDateTime(json['createdTime']),
        title: json['title'],
        description: json['description'],
        id: json['id'],
        isDone: json['isDone'],
      );

  Map<String, dynamic> toJson() => {
        'createdTime': Util.fromDateTimeToJson(createdTime),
        'title': title,
        'description': description,
        'id': id,
        'isDone': isDone,
      };
}
