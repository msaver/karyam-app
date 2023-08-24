import 'package:flutter/material.dart';
import 'package:karyam/data/category/category.dart';
import 'package:karyam/data/db_repo_impl.dart';
import 'package:karyam/data/preference/preferences_data.dart';
import 'package:karyam/enums/enums.dart';
import 'package:karyam/model/task_item.dart';
import 'package:realm/realm.dart';

class HomeViewModel extends ChangeNotifier {
  List<Category> categories = [];
  DbRepoImpl? _dbRepoImpl;
  List<TaskItem> tasks = [];
  Category? _selectedCategory;
  Category? _selectedCategoryForCreateTask;
  DateTime _selectedDateTime = DateTime.now();
  TextEditingController taskEditingController = TextEditingController();
  DateTime filterDate = DateTime.now();
  ApplyFilter? applyFilterType;
  String? userName;

  HomeViewModel({String? taskId}) {
    _dbRepoImpl = DbRepoImpl();
    getAllCategory();
    getAllTask();
    updateCategoryValues();
    updateSelectedCategory(categories[0]);
    getUserName();
    if (taskId != null) {
      getTask(taskId);
    }
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
    updateCategoryValues();
    notifyListeners();
  }

  Category get selectedCategory => _selectedCategory!;

  set selectedCategory(Category value) {
    _selectedCategory = value;
    applyFilterType = ApplyFilter.none;
    updateTasks();
    notifyListeners();
  }

  DateTime get selectedDateTime => _selectedDateTime;

  set selectedDateTime(DateTime value) {
    _selectedDateTime = value;
    notifyListeners();
  }

  void addTask(String taskName, Category selectedCategory,
      DateTime selectedDateTime) {
    _dbRepoImpl!.addNewTask(
        taskName: taskName,
        selectedCategory: selectedCategory,
        selectedDateTime: selectedDateTime);
    updateCategoryValues();
    notifyListeners();
  }

  void getAllTask() {
    this.tasks.clear();
    List<TaskItem> tasks = getAllTaskFromDb();
    if (tasks.isNotEmpty) {
      this.tasks.addAll(tasks);
    }
    notifyListeners();
  }

  void taskComplete(bool value, TaskItem task) {
    Task taskNewValue = _dbRepoImpl!
        .taskCompletion(value: value, id: ObjectId.fromHexString(task.id!));
    TaskItem item = TaskItem(
        category: taskNewValue.category,
        id: taskNewValue.id.hexString,
        isCompleted: taskNewValue.isCompleted,
        taskName: taskNewValue.taskName,
        createdDate: taskNewValue.createdDate.toLocal(),
        tobeDoneDate: taskNewValue.tobeDoneDate.toLocal());
    tasks[tasks.indexWhere(
            (element) => element.id == taskNewValue.id.hexString)] = item;
    updateCategoryValues();
    notifyListeners();
  }

  void updateCategoryValues() {
    for (var element in categories) {
      if (element.name == "Completed") {
        int totalCount = getAllTaskFromDb().length;
        int completedTask = getAllTaskFromDb()
            .where((taskElement) => taskElement.isCompleted == true)
            .length;
        element.totalCount = totalCount;
        element.pendingCount = completedTask;
      } else if (element.name == "All") {
        int totalCount = getAllTaskFromDb().length;
        int pendingTask = getAllTaskFromDb()
            .where((taskElement) => taskElement.isCompleted == false)
            .length;
        element.totalCount = totalCount;
        element.pendingCount = pendingTask;
      } else {
        int totalCount = getAllTaskFromDb()
            .where((taskElement) => taskElement.category!.name == element.name)
            .length;
        int pendingCount = getAllTaskFromDb()
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
        return item.totalCount != null
            ? (item.pendingCount! / item.totalCount!) == 0
            ? 1
            : 1 - (item.pendingCount! / item.totalCount!)
            : 0;
      }
    } else {
      if (item.pendingCount == item.totalCount) {
        return 0;
      } else {
        return (item.pendingCount! / item.totalCount!) == 0
            ? 1
            : 1 - (item.pendingCount! / item.totalCount!);
      }
    }
  }

  void updateTasks() {
    tasks.clear();
    List<TaskItem> items = [];
    if (selectedCategory.name == "Completed") {
      items.addAll(
          getAllTaskFromDb().where((element) => element.isCompleted == true));
    } else if (selectedCategory.name == "All") {
      items.addAll(
          getAllTaskFromDb().where((element) => element.isCompleted == false));
    } else {
      items.addAll(getAllTaskFromDb().where((element) =>
      element.isCompleted == false &&
          element.category!.name == selectedCategory.name));
    }

    if (applyFilterType == ApplyFilter.today ||
        applyFilterType == ApplyFilter.tomorrow ||
        applyFilterType == ApplyFilter.customDate) {
      tasks.addAll(items.where((element) {
        return element.tobeDoneDate.toString().split(" ")[0] ==
            filterDate.toString().split(" ")[0];
      }).toList());
    } else if (applyFilterType == ApplyFilter.overdue) {
      tasks.addAll(items
          .where((element) => element.tobeDoneDate!.isBefore(DateTime.now()))
          .toList());
    } else {
      tasks.addAll(items);
    }

    tasks.sort((a, b) => b.tobeDoneDate!.compareTo(a.tobeDoneDate!));

    notifyListeners();
  }

  List<TaskItem> getAllTaskFromDb() {
    List<TaskItem> data = [];
    _dbRepoImpl!.getAllTask().forEach((element) {
      data.add(TaskItem(
          category: element.category,
          id: element.id.hexString,
          isCompleted: element.isCompleted,
          taskName: element.taskName,
          createdDate: element.createdDate.toLocal(),
          tobeDoneDate: element.tobeDoneDate.toLocal()));
    });
    return data;
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
        filterDate = DateTime.now();
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

  Category get selectedCategoryForCreateTask =>
      _selectedCategoryForCreateTask ?? categories[1];

  set selectedCategoryForCreateTask(Category value) {
    _selectedCategoryForCreateTask = value;
    notifyListeners();
  }

  void getUserName() async {
    userName = await PreferencesData.getUserName();
    notifyListeners();
  }

  void closeDb() {
    _dbRepoImpl!.closeDb();
  }

  void deleteTask(TaskItem task) {
    _dbRepoImpl!.deleteTask(id: ObjectId.fromHexString(task.id!));
    getAllTask();
    updateCategoryValues();
    notifyListeners();
  }

  void getTask(String taskId) {
    Task task = _dbRepoImpl!.getTaskById(id: ObjectId.fromHexString(taskId));
    taskEditingController.text = task.taskName;
    selectedCategoryForCreateTask = task.category!;
    // print(task.tobeDoneDate.toLocal());
    selectedDateTime = task.tobeDoneDate.toLocal();
    // notifyListeners();
  }

  void updateTask(String taskId) {
    Task task = _dbRepoImpl!.getTaskById(id: ObjectId.fromHexString(taskId));
    _dbRepoImpl!.updateTask(task: Task(
        ObjectId.fromHexString(taskId), taskEditingController.text, task.createdDate,
        selectedDateTime.toUtc(), category: selectedCategoryForCreateTask));
  }
}
