import 'package:localstorage/localstorage.dart';
import 'package:todo/assets/constants.dart';
import 'package:todo/model/task/task.dart';
import 'storage_service.dart';
import 'package:hive_flutter/hive_flutter.dart';

// Data Access Layer
abstract class Database {
  List<Task> getTaskListFromStorage();

  Future<void> saveTaskListToStorage(List<Task> taskList);
}

abstract class HiveDatabase extends Database {
  Future<void> updateTask(int index, Task task);

  Future<void> addTask(Task task);

  Future<void> deleteTask(Task task);
}

class StorageHiveDatabase extends HiveDatabase {
  @override
  Future<void> deleteTask(Task task) async {}

  @override
  List<Task> getTaskListFromStorage() {
    // TODO: implement getTaskListFromStorage
     return Hive.box<Task>(tasksKey).values.toList();
  }

  @override
  Future<void> saveTaskListToStorage(List<Task> taskList) async {
    await Hive.box<Task>(tasksKey).addAll(taskList);
  }

  @override
  Future<void> updateTask(int index, Task task) async {
    await Hive.box<Task>(tasksKey).putAt(index, task);
  }

  @override
  Future<void> addTask(Task task) async {
    // Box box = await Hive.openBox<Task>(tasksKey);
    // await box.add(task);
    await Hive.box<Task>(tasksKey).put(task.id, task);
  }
}

class StorageDatabase extends Database with StorageHelper {
  final LocalStorage localStorage;

  StorageDatabase({required this.localStorage});

  List? _getFromStorage(String storageKey) {
    List? storageItems = localStorage.getItem(storageKey);
    return storageItems;
  }

  Future<void> _saveToStorage<T>(String path, List<T> savedList) async {
    await localStorage.setItem(path, savedList);
  }

  @override
  List<Task> getTaskListFromStorage() {
    List<Task> taskList = [];
    try {
      List? storageItems = _getFromStorage(taskListKey);
      if (storageItems == null) return taskList;
      return convertFromJsonListToObjectList<Task>(
        storageItems: storageItems,
        builder: (json) => Task.fromJson(json),
      );
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<void> saveTaskListToStorage(List<Task> taskList) async {
    try {
      List items = convertFromObjectListToJsonList<Task>(
        items: taskList,
        builder: (Task value) => value.toJson(),
      );
      await _saveToStorage(taskListKey, items);
    } catch (error) {
      rethrow;
    }
  }
}
