import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:todo/model/task/task.dart';
import 'package:todo/provider/task_list_provider.dart';
import 'package:todo/service/storage_database.dart';

import 'task_list_provider_test.mocks.dart';

@GenerateMocks([StorageDatabase])
void main() {
  late TaskListProvider taskListProvider;
  late MockStorageDatabase mockStorageDatabase;
  final Task defaultTask = Task(id: '123', name: 'read book');
  setUp(() {
    mockStorageDatabase = MockStorageDatabase();
    taskListProvider = TaskListProvider(
        taskList: [defaultTask], storageDatabase: mockStorageDatabase);
  });
  group('Add or update existing task', () {
    test(
        'Add task successfully with'
        'a new task with different id', () async {
      var didNotifyListeners = false;
      taskListProvider.addListener(() => didNotifyListeners = true);
      await taskListProvider.updateTask(Task(id: '456', name: 'read book'));
      expect(taskListProvider.taskList,
          [defaultTask, Task(id: '456', name: 'read book')]);
      expect(didNotifyListeners, true);
      verify(mockStorageDatabase.saveTaskListToStorage(any)).called(1);
    });

    test(
        'Update current task'
        'There is no thing change in the current task'
        'no save to storage'
        'and no update to task list', () async {
      var didNotifyListeners = false;
      taskListProvider.addListener(() => didNotifyListeners = true);
      await taskListProvider.updateTask(defaultTask);
      expect(taskListProvider.taskList, [defaultTask]);
      expect(didNotifyListeners, false);
      verifyNever(mockStorageDatabase.saveTaskListToStorage(any));
    });

    test(
        'Update current task'
        'update the name and description'
        'save to storage'
        'and update to task list', () async {
      var didNotifyListeners = false;
      taskListProvider.addListener(() => didNotifyListeners = true);
      await taskListProvider.updateTask(
          Task(id: '123', name: 'watch movie', description: 'watch one piece'));
      expect(taskListProvider.taskList, [
        Task(id: '123', name: 'watch movie', description: 'watch one piece')
      ]);
      expect(didNotifyListeners, true);
      verify(mockStorageDatabase.saveTaskListToStorage(any)).called(1);
    });
  });

  group('remove task', () {
    test(
        'remove a task that exists in task list'
        'a task is removed from task list', () async {
      var didNotifyListeners = false;
      taskListProvider.addListener(() => didNotifyListeners = true);
      await taskListProvider.removeTask(defaultTask);
      expect(taskListProvider.taskList, []);
      expect(didNotifyListeners, true);
    });
    test(
        'remove a task that does not exist in task list'
        'no task is removed from the task list', () async {
      var didNotifyListeners = false;
      taskListProvider.addListener(() => didNotifyListeners = true);
      await taskListProvider.removeTask(Task(id: '456', name: 'go to cinema'));
      expect(taskListProvider.taskList, [defaultTask]);
      expect(didNotifyListeners, false);
    });
  });

  test(
      'select an incomplete task'
      'task is marked as completed', () async {
    var didNotifyListeners = false;
    taskListProvider.addListener(() => didNotifyListeners = true);
    await taskListProvider.selectTask(defaultTask);
    expect(defaultTask.isComplete, true);
    expect(didNotifyListeners, true);
  });
}
