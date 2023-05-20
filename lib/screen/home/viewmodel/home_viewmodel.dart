import 'package:flutter/material.dart';
import 'package:msaver/data/category/category.dart';
import 'package:msaver/data/db_repo_impl.dart';
import 'package:msaver/enums/enums.dart';
import 'package:realm/realm.dart';

class HomeViewModel extends ChangeNotifier {
  List<Category> categories = [];
  DbRepoImpl? _dbRepoImpl;
  List<Task> tasks = [];
  Category? _selectedCategory;
  DateTime _selectedDateTime = DateTime.now();
  TextEditingController taskEditingController = TextEditingController();
  DateTime filterDate = DateTime.now();
  ApplyFilter? applyFilterType;

  HomeViewModel() {
    _dbRepoImpl = DbRepoImpl();
    getAllCategory();
    getAllTask();
    updateCategoryValues();
    updateSelectedCategory(categories[0]);
  }

  void getAllCategory() {
    this.categories.clear();
    List<Category> categories = _dbRepoImpl!.getAllCategory();
    this.categories.add(Category(ObjectId(), "All", 0xFF000000));
    this.categories.addAll(categories);
    this.categories.add(Category(ObjectId(), "Completed", 0xCB5959FF));
  }

  void addNewCategory(String categoryName, Color selectedColor) {
    _dbRepoImpl!.addNewCategory(
        categoryName: categoryName, selectedColor: selectedColor);
    getAllCategory();
    notifyListeners();
  }

  Category get selectedCategory => _selectedCategory!;

  set selectedCategory(Category value) {
    _selectedCategory = value;
    updateTasks();
    notifyListeners();
  }

  DateTime get selectedDateTime => _selectedDateTime;

  set selectedDateTime(DateTime value) {
    _selectedDateTime = value;
    notifyListeners();
  }

  void addTask(
      String taskName, Category selectedCategory, DateTime selectedDateTime) {
    _dbRepoImpl!.addNewTask(
        taskName: taskName,
        selectedCategory: selectedCategory,
        selectedDateTime: selectedDateTime);
    updateCategoryValues();
    notifyListeners();
  }

  void getAllTask() {
    this.tasks.clear();
    List<Task> tasks = _dbRepoImpl!.getAllTask();
    if (tasks.isNotEmpty) {
      this.tasks.addAll(tasks);
    }
    notifyListeners();
  }

  void taskComplete(bool value, Task task) {
    Task taskNewValue = _dbRepoImpl!.taskCompletion(value: value, task: task);
    tasks[tasks.indexWhere((element) => element.id == taskNewValue.id)] =
        taskNewValue;
    updateCategoryValues();
    notifyListeners();
  }

  void updateCategoryValues() {
    for (var element in categories) {
      if (element.name == "Completed") {
        int totalCount = tasks.length;
        int completedTask = tasks
            .where((taskElement) => taskElement.isCompleted == true)
            .length;
        element.totalCount = totalCount;
        element.pendingCount = completedTask;
      } else if (element.name == "All") {
        int totalCount = tasks.length;
        int pendingTask = tasks
            .where((taskElement) => taskElement.isCompleted == false)
            .length;
        element.totalCount = totalCount;
        element.pendingCount = pendingTask;
      } else {
        int totalCount = tasks
            .where((taskElement) => taskElement.category!.name == element.name)
            .length;
        int pendingCount = tasks
            .where((taskElement) =>
                taskElement.isCompleted == false &&
                taskElement.category!.name == element.name)
            .length;
        _dbRepoImpl!.updateCountOfTask(
            category: element,
            totalTask: totalCount,
            completeTask: pendingCount);
      }
    }
    notifyListeners();
  }

  double getProgress(Category item) {
    if (item.name == "Completed") {
      if (item.pendingCount == item.totalCount) {
        return 1.0;
      } else {
        return (item.pendingCount! / item.totalCount!);
      }
    } else if (item.name == "All") {
      if (item.pendingCount == item.totalCount) {
        return 0.0;
      } else {
        return (item.pendingCount! / item.totalCount!) == 0
            ? 1
            : (item.pendingCount! / item.totalCount!);
      }
    } else {
      if (item.pendingCount == item.totalCount) {
        return 0;
      } else {
        return (item.pendingCount! / item.totalCount!) == 0
            ? 1
            : (item.pendingCount! / item.totalCount!);
      }
    }
  }

  void updateTasks() {
    tasks.clear();
    List<Task> items = [];
    if (selectedCategory.name == "Completed") {
      items.addAll(_dbRepoImpl!
          .getAllTask()
          .where((element) => element.isCompleted == true));
    } else if (selectedCategory.name == "All") {
      items.addAll(_dbRepoImpl!
          .getAllTask()
          .where((element) => element.isCompleted == false));
    } else {
      items.addAll(_dbRepoImpl!.getAllTask().where((element) =>
          element.isCompleted == false &&
          element.category!.name == selectedCategory.name));
    }

    if (applyFilterType == ApplyFilter.today ||
        applyFilterType == ApplyFilter.tomorrow ||
        applyFilterType == ApplyFilter.customDate) {
      tasks.addAll(items
          .where((element) =>
              element.tobeDoneDate.toString().split(" ")[0] ==
              filterDate.toString().split(" ")[0])
          .toList());
    } else if(applyFilterType == ApplyFilter.overdue){
      tasks.addAll(items
          .where((element) =>
      element.tobeDoneDate.isBefore(DateTime.now())).toList());
    } else{
      tasks.addAll(items);
    }

    notifyListeners();
  }

  void updateSelectedCategory(Category item) {
    selectedCategory = item;
  }

  void applyFilter(ApplyFilter applyFilter, {DateTime? dateTime}) {
    applyFilterType = applyFilter;
    switch (applyFilter) {
      case ApplyFilter.today:
        filterDate = DateTime.now();
        break;
      case ApplyFilter.tomorrow:
        filterDate = DateTime.now().add(const Duration(days: 1));
        break;
      case ApplyFilter.overdue:
        filterDate = DateTime.now().subtract(const Duration(days: 1));
        break;
      case ApplyFilter.customDate:
        filterDate = dateTime!;
        break;
      default:
        applyFilterType = applyFilter;
        filterDate = DateTime.now();
        break;
    }
    updateTasks();
  }
}
