import 'package:flutter/cupertino.dart';
import 'package:todo/model/task/task.dart';
import 'package:todo/provider/task_list_provider.dart';

String documentIdFromCurrentDate() => DateTime.now().toIso8601String();

class SelectedTaskProvider extends ChangeNotifier {
  Task? task;
  bool loading;
  String description;
  String name;

  final TaskListProvider taskListProvider;

  // fromKey to allow save and validate inside provider

  SelectedTaskProvider({
    this.task,
    this.loading = false,
    required this.taskListProvider,
    this.description = "",
    this.name = "",
  });

  Future<void> updateSelectedTask() async {
    try {
      updateLoading();
      Task task = Task(
        id: this.task?.id ?? documentIdFromCurrentDate(),
        description: description,
        name: name,
        isComplete: this.task?.isComplete ?? false,
      );
      await taskListProvider.updateTask(task);
    } catch (error) {
      rethrow;
    }
  }

  void updateLoading() {
    loading = !loading;
    notifyListeners();
  }

  void updateTask({String? description, String? name}) {
    this.description = description ?? this.description;
    this.name = name ?? this.name;
  }

  String get successMessage =>
      task != null ? 'Save task successfully!' : 'Add task successfully!';

  String get failMessage =>
      task != null ? 'Failed to save task!' : 'Failed to update task!';
}
