import 'package:localstorage/localstorage.dart';
import 'package:todo/assets/constants.dart';
import 'package:todo/model/task/task.dart';
import 'storage_service.dart';

// Data Access Layer
abstract class Database {
  List<Task> getTaskListFromStorage();

  Future<void> saveTaskListToStorage(List<Task> taskList);
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
