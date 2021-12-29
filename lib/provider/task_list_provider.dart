import 'package:flutter/material.dart';
import 'package:todo/model/task/task.dart';
import 'package:todo/service/storage_database.dart';

class TaskListProvider extends ChangeNotifier {
  List<Task> taskList;

  final HiveDatabase storageDatabase;

  TaskListProvider({required this.taskList, required this.storageDatabase});

  List<Task> get completeTasks =>
      taskList.where((task) => task.isComplete).toList();

  List<Task> get incompleteTasks =>
      taskList.where((task) => !task.isComplete).toList();

  Future<void> _addTask(Task task) async {
    await storageDatabase.addTask(task);
    getTaskList();
  }

  void getTaskList() {
    taskList = storageDatabase.getTaskListFromStorage();
    notifyListeners();
  }

  Future<void> updateTask(Task task) async {
    try {
      Task? selectedTask;
      try {
        selectedTask = taskList.firstWhere((element) => element.id == task.id);
      } catch (error) {
        selectedTask = null;
      }
      // no task in list // or same task
      if (selectedTask != null && task == selectedTask) return;
      _addTask(task);
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  Future<void> selectTask(Task task) async {
    // same task save ref in the task list
    task.isComplete = !task.isComplete;
    await task.save();
    notifyListeners();
  }

  Future<void> removeTask(Task task) async {
    await task.delete();
    getTaskList();
    notifyListeners();
  }

  Task getTaskById(String taskId) {
    return taskList.firstWhere((element) => element.id == taskId,
        orElse: () => Task(id: '', name: ''));
  }
}
