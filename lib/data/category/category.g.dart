// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class Category extends _Category
    with RealmEntity, RealmObjectBase, RealmObject {
  Category(
    ObjectId id,
    String name,
    int colorCode,
    int count,
  ) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'colorCode', colorCode);
    RealmObjectBase.set(this, 'count', count);
  }

  Category._();

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, 'id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  int get colorCode => RealmObjectBase.get<int>(this, 'colorCode') as int;
  @override
  set colorCode(int value) => RealmObjectBase.set(this, 'colorCode', value);

  @override
  int get count => RealmObjectBase.get<int>(this, 'count') as int;
  @override
  set count(int value) => RealmObjectBase.set(this, 'count', value);

  @override
  Stream<RealmObjectChanges<Category>> get changes =>
      RealmObjectBase.getChanges<Category>(this);

  @override
  Category freeze() => RealmObjectBase.freezeObject<Category>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(Category._);
    return const SchemaObject(ObjectType.realmObject, Category, 'Category', [
      SchemaProperty('id', RealmPropertyType.objectid, primaryKey: true),
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('colorCode', RealmPropertyType.int),
      SchemaProperty('count', RealmPropertyType.int),
    ]);
  }
}

class Task extends _Task with RealmEntity, RealmObjectBase, RealmObject {
  static var _defaultsSet = false;

  Task(
    ObjectId id,
    String taskName,
    DateTime createdDate,
    DateTime tobeDoneDate, {
    Category? category,
    bool isCompleted = false,
  }) {
    if (!_defaultsSet) {
      _defaultsSet = RealmObjectBase.setDefaults<Task>({
        'isCompleted': false,
      });
    }
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'taskName', taskName);
    RealmObjectBase.set(this, 'category', category);
    RealmObjectBase.set(this, 'createdDate', createdDate);
    RealmObjectBase.set(this, 'tobeDoneDate', tobeDoneDate);
    RealmObjectBase.set(this, 'isCompleted', isCompleted);
  }

  Task._();

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, 'id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get taskName =>
      RealmObjectBase.get<String>(this, 'taskName') as String;
  @override
  set taskName(String value) => RealmObjectBase.set(this, 'taskName', value);

  @override
  Category? get category =>
      RealmObjectBase.get<Category>(this, 'category') as Category?;
  @override
  set category(covariant Category? value) =>
      RealmObjectBase.set(this, 'category', value);

  @override
  DateTime get createdDate =>
      RealmObjectBase.get<DateTime>(this, 'createdDate') as DateTime;
  @override
  set createdDate(DateTime value) =>
      RealmObjectBase.set(this, 'createdDate', value);

  @override
  DateTime get tobeDoneDate =>
      RealmObjectBase.get<DateTime>(this, 'tobeDoneDate') as DateTime;
  @override
  set tobeDoneDate(DateTime value) =>
      RealmObjectBase.set(this, 'tobeDoneDate', value);

  @override
  bool get isCompleted =>
      RealmObjectBase.get<bool>(this, 'isCompleted') as bool;
  @override
  set isCompleted(bool value) =>
      RealmObjectBase.set(this, 'isCompleted', value);

  @override
  Stream<RealmObjectChanges<Task>> get changes =>
      RealmObjectBase.getChanges<Task>(this);

  @override
  Task freeze() => RealmObjectBase.freezeObject<Task>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(Task._);
    return const SchemaObject(ObjectType.realmObject, Task, 'Task', [
      SchemaProperty('id', RealmPropertyType.objectid, primaryKey: true),
      SchemaProperty('taskName', RealmPropertyType.string),
      SchemaProperty('category', RealmPropertyType.object,
          optional: true, linkTarget: 'Category'),
      SchemaProperty('createdDate', RealmPropertyType.timestamp),
      SchemaProperty('tobeDoneDate', RealmPropertyType.timestamp),
      SchemaProperty('isCompleted', RealmPropertyType.bool),
    ]);
  }
}
