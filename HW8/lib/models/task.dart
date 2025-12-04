import 'dart:math';

class Task {
  final String id = Random().nextInt(1000000).toString();
  String title;
  String description = '';
  bool isCompleted = false;

  Task(this.title);
}