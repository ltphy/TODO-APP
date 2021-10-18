import 'package:flutter/material.dart';
import 'package:todo/model/task/task.dart';
import 'package:todo/service/storage_database.dart';

class TaskListProvider extends ChangeNotifier {
  final List<Task> taskList;
  final StorageDatabase storageDatabase;

  TaskListProvider({
    required this.taskList,
    required this.storageDatabase,
  });

  List<Task> get completeTasks =>
      taskList.where((task) => task.isComplete).toList();

  List<Task> get incompleteTasks =>
      taskList.where((task) => !task.isComplete).toList();

  Future<void> _addTask(Task task) async {
    taskList.add(task);
    notifyListeners();
    await saveTaskList();
  }

  Future<void> saveTaskList() async {
    await storageDatabase.saveTaskListToStorage(taskList);
  }

  Future<void> updateTask(Task task) async {
    final int taskIndex =
        taskList.indexWhere((element) => element.id == task.id);
    if (taskIndex == -1) {
      await _addTask(task);
      return;
    }
    Task currentTask = taskList[taskIndex];
    // no task in list // or same task
    if (task == currentTask) return;
    taskList[taskIndex] = task;
    notifyListeners();
    await saveTaskList();
    return;
  }

  Future<void> selectTask(Task task) async {
    // same task save ref in the task list
    task.isComplete = !task.isComplete;
    notifyListeners();
    await saveTaskList();
  }

  Future<void> removeTask(Task task) async {
    if (taskList.remove(task)) {
      notifyListeners();
      await saveTaskList();
    }
  }

  Task getTaskById(String taskId) {
    return taskList.firstWhere((element) => element.id == taskId,
        orElse: () => Task(id: '', name: ''));
  }
}
