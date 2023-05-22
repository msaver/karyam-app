import 'package:flutter/material.dart';
import 'package:msaver/data/category/category.dart';
import 'package:realm/realm.dart';

abstract class DbRepository {
  List<Category> getAllCategory();

  List<Task> getAllTask();

  void addNewCategory(
      {required String categoryName, required Color selectedColor});

  void addNewTask(
      {required String taskName,
      required Category selectedCategory,
      required DateTime selectedDateTime});

  Task taskCompletion({required bool value, required ObjectId id});

  void updateCountOfTask(
      {required int totalTask,
      required int completeTask,
      required Category category});
}
