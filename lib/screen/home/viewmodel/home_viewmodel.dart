import 'package:flutter/material.dart';
import 'package:msaver/data/category/category.dart';
import 'package:realm/realm.dart';

class HomeViewModel extends ChangeNotifier{

  late Realm realm;
  List<Category> categories= [];

  HomeViewModel(){

    var config = Configuration.local([Category.schema], initialDataCallback: (realm){
      realm.addAll([Category(
        ObjectId(),
        "Home",
        0xFF177e89,
        0,
      ), Category(
        ObjectId(),
        "Personal",
        0xFFDB8480,
        0,
      ), Category(
        ObjectId(),
        "Work",
        0xFF335C67,
        0,
      ), Category(
        ObjectId(),
        "Complete",
        0xCB5959FF,
        0,
      )]);
    });
    realm = Realm(config);
    getAllCategory();
  }

  void getAllCategory(){
    this.categories.clear();
    List<Category> categories = realm.all<Category>().toList();
   this.categories.addAll(categories);
  }

  void addNewCategory(String categoryName, Color selectedColor) {
    Category category = Category(ObjectId(), categoryName, selectedColor.value,0);
    realm.write(() => realm.add(category));
    getAllCategory();
    notifyListeners();
  }







}