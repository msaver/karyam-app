import 'package:realm/realm.dart';
part 'category.g.dart';

@RealmModel()
class _Category{

  @PrimaryKey()
  late ObjectId id;

  late String name;

  late int colorCode;

  late int count;

}

@RealmModel()
class _Task {

  @PrimaryKey()
  late ObjectId id;

  late String taskName;

  late _Category? category;

  late DateTime createdDate;

  late DateTime tobeDoneDate;

  late bool isCompleted = false;

}