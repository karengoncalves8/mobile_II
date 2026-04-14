import 'package:task_list/enums/task_priority.dart';

class TaskItem {
  String name;
  String description;
  TaskPriority priority;
  bool isDone;

  TaskItem({
    required this.name,
    required this.description,
    this.priority = TaskPriority.medium,
    this.isDone = false,
  });

  void toggleDone() {
    isDone = !isDone;
  }
}
