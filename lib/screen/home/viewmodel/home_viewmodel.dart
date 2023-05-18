import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:msaver/data/category/category.dart';
import 'package:realm/realm.dart';

class HomeViewModel extends ChangeNotifier {
  late Realm realm;
  List<Category> categories = [];
  List<Task> tasks = [];
  Category? _selectedCategory;
  DateTime _selectedDateTime = DateTime.now();
  String? dateType;
  TextEditingController taskEditingController = TextEditingController();

  HomeViewModel() {
    var config = Configuration.local([Task.schema, Category.schema],
        initialDataCallback: (realm) {
      realm.addAll<Category>([
        Category(
          ObjectId(),
          "Home",
          0xFF177e89,
          0,
        ),
        Category(
          ObjectId(),
          "Personal",
          0xFFDB8480,
          0,
        ),
        Category(
          ObjectId(),
          "Work",
          0xFF335C67,
          0,
        ),
        Category(
          ObjectId(),
          "Complete",
          0xCB5959FF,
          0,
        )
      ]);
    });
    realm = Realm(config);
    getAllCategory();
    getAllTask();
  }

  void getAllCategory() {
    this.categories.clear();
    List<Category> categories = realm.all<Category>().toList();
    this.categories.addAll(categories);
    selectedCategory = this.categories[0];
  }

  void addNewCategory(String categoryName, Color selectedColor) {
    Category category =
        Category(ObjectId(), categoryName, selectedColor.value, 0);
    realm.write(() => realm.add(category));
    getAllCategory();
    notifyListeners();
  }

  Category get selectedCategory => _selectedCategory!;

  set selectedCategory(Category value) {
    _selectedCategory = value;
    notifyListeners();
  }

  DateTime get selectedDateTime => _selectedDateTime!;

  set selectedDateTime(DateTime value) {
    _selectedDateTime = value;
    notifyListeners();
  }

  String getValueOfDate(DateTime dateTime) {
    DateTime date = DateTime(dateTime.year, dateTime.month, dateTime.day);
    if (date ==
        DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day)) {
      return "Today";
    } else if (date ==
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)
            .add(const Duration(days: 1))) {
      return "Tomorrow";
    } else {
      return DateFormat("EEE, MMM dd").format(dateTime).toString();
    }
  }

  void addTask(
      String taskName, Category selectedCategory, DateTime selectedDateTime) {
    // var config = Configuration.local([Task.schema, Category.schema]);
    // Realm realm = Realm(config);
    Task task = Task(ObjectId(), taskName, DateTime.now(), selectedDateTime,
        category: selectedCategory);
    realm.write(() => realm.add(task));
    realm.close();
  }

  void getAllTask() {
    this.tasks.clear();
    // var config = Configuration.local([Task.schema, Category.schema]);
    // Realm realm = Realm(config);
    List<Task> tasks = realm.all<Task>().toList();
    if (tasks.isNotEmpty) {
      this.tasks.addAll(tasks);
    }
    notifyListeners();
  }

  void taskComplete(bool value, Task task) {
    // var config = Configuration.local([Task.schema, Category.schema]);
    // Realm realm = Realm(config);
    realm.write(() => task.isCompleted = true);
    Task taskNewValue = realm.all<Task>().query(r'id == $0', [task.id]).first;
    tasks[tasks.indexWhere((element) => element.id == taskNewValue.id)] =
        taskNewValue;
    notifyListeners();
  }
}
