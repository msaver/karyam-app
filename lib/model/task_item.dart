
import 'package:msaver/data/category/category.dart';

class TaskItem {
  String? id;
  String? taskName;
  DateTime? createdDate;
  DateTime? tobeDoneDate;
  Category? category;
  bool? isCompleted = false;

  TaskItem(
      {this.id,
      this.taskName,
      this.createdDate,
      this.tobeDoneDate,
      this.category,
      this.isCompleted});
}
