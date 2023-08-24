import 'dart:ui';

import 'package:karyam/data/category/category.dart';
import 'package:karyam/data/db_repository.dart';
import 'package:realm/realm.dart';

class DbRepoImpl implements DbRepository {
  Realm? _realm;

  DbRepoImpl() {
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
  void addNewCategory(
      {required String categoryName, required Color selectedColor}) {
    Category category = Category(ObjectId(), categoryName, selectedColor.value);
    _realm!.write(() => _realm!.add(category));
  }

  @override
  void addNewTask(
      {required String taskName,
      required Category selectedCategory,
      required DateTime selectedDateTime}) {
    Task task = Task(
        ObjectId(), taskName, DateTime.now().toUtc(), selectedDateTime.toUtc(),
        category: selectedCategory);
    _realm!.write(() {
      _realm!.add(task);
    });
    // print(item.tobeDoneDate);
  }

  @override
  Task taskCompletion({required bool value, required ObjectId id}) {

    Task task = _realm!.all<Task>().query(r'id == $0', [id]).first;

    _realm!.write(() => task.isCompleted = value);
    return _realm!.all<Task>().query(r'id == $0', [task.id]).first;
  }

  @override
  void updateCountOfTask(
      {required int totalTask,
      required int completeTask,
      required Category category}) {
    _realm!.write(() {
      category.pendingCount = completeTask;
      category.totalCount = totalTask;
    });
  }

  @override
  void closeDb() {
   _realm!.close();
  }

  @override
  void deleteTask({required ObjectId id}) {
    Task task = _realm!.all<Task>().query(r'id == $0', [id]).first;

    _realm!.write(() => _realm!.delete(task));
  }

  @override
  Task getTaskById({required ObjectId id}) {
    Task task = _realm!.all<Task>().query(r'id == $0', [id]).first;
    return task;
  }

  @override
  void updateTask({required Task task}) {
    _realm!.write(() {
      _realm!.add(task, update: true);
    });
  }

}
