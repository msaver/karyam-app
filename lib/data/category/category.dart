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