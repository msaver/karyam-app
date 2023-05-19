import 'dart:ui';

import 'package:msaver/data/category/category.dart';
import 'package:msaver/data/db_repository.dart';
import 'package:realm/realm.dart';

class DbRepoImpl implements DbRepository{

  Realm? _realm;

  DbRepoImpl(){
    var config = Configuration.local([Task.schema, Category.schema],
        schemaVersion: 1, initialDataCallback: (realm) {
          realm.addAll<Category>([
            Category(
              ObjectId(),
              "Home",
              0xFF177e89,
            ),
            Category(
              ObjectId(),
              "Personal",
              0xFFDB8480,
            ),
            Category(
              ObjectId(),
              "Work",
              0xFF335C67,
            ),
          ]);
        });
    _realm = Realm(config);
  }


  @override
  List<Category> getAllCategory() {
    return _realm!.all<Category>().toList();
  }

  @override
  List<Task> getAllTask() {
    return _realm!.all<Task>().toList();
  }

  @override
  void addNewCategory({required String categoryName, required Color selectedColor}) {

    Category category =
    Category(ObjectId(), categoryName, selectedColor.value);
    _realm!.write(() => _realm!.add(category));

  }

  @override
  void addNewTask({required String taskName, required Category selectedCategory, required DateTime selectedDateTime}) {
    Task task = Task(ObjectId(), taskName, DateTime.now(), selectedDateTime,
        category: selectedCategory);
    _realm!.write(() => _realm!.add(task));
  }

  @override
  Task taskCompletion({required bool value, required Task task}) {
    _realm!.write(() => task.isCompleted = value);
    return _realm!.all<Task>().query(r'id == $0', [task.id]).first;
  }

  @override
  void updateCountOfTask({required int totalTask, required int completeTask, required Category category}) {
    _realm!.write(() {
      category.pendingCount = completeTask;
      category.totalCount = totalTask;
    });
  }

}