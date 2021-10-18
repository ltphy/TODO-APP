import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:localstorage/localstorage.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:todo/assets/constants.dart';
import 'package:todo/model/task/task.dart';
import 'package:todo/service/storage_database.dart';

import 'storage_database_test.mocks.dart';

@GenerateMocks([LocalStorage])
void main() {
  late MockLocalStorage mockLocalStorage;
  late StorageDatabase storageDatabase;
  final List<Task> defaultTaskList = [
    Task(id: '123', name: 'Go To School'),
    Task(id: '456', name: 'homework')
  ];
  setUp(() {
    mockLocalStorage = MockLocalStorage();
    storageDatabase = StorageDatabase(localStorage: mockLocalStorage);
  });

  void stubGetItemFromStorage(List? mapList) {
    when(mockLocalStorage.getItem(taskListKey)).thenReturn(mapList);
  }

  group('get task list from storage', () {
    test('get task list from storage' 'items available', () {
      stubGetItemFromStorage([
        {"id": '123', "name": 'Go To School'},
        {"id": '456', "name": 'homework'}
      ]);
      List<Task> taskList = storageDatabase.getTaskListFromStorage();

      expect(taskList, defaultTaskList);
    });

    test('get empty task list from storage', () {
      stubGetItemFromStorage(null);
      List<Task> taskList = storageDatabase.getTaskListFromStorage();
      expect(taskList, []);
    });

    test('get empty task list failed', () {
      final exception = PlatformException(code: 'ERROR');
      when(mockLocalStorage.getItem(taskListKey)).thenThrow(exception);
      try {
        storageDatabase.getTaskListFromStorage();
      } catch (error) {
        expect(error, exception);
      }
    });
  });

  void stubSaveItemToStorage(String path, List savedList) {
    when(mockLocalStorage.setItem(path, savedList)).thenAnswer((_) async {});
  }

  group('save task list to storage successfully', () {
    test('save task list to storage', () async {
      stubSaveItemToStorage(taskListKey, defaultTaskList);
      await storageDatabase.saveTaskListToStorage(defaultTaskList);

      verify(mockLocalStorage.setItem(any, any)).called(1);
    });

    test('save task list fail', () async {
      final exception = PlatformException(code: 'ERROR');
      when(mockLocalStorage.setItem(taskListKey, defaultTaskList))
          .thenThrow(exception);
      try {
        await storageDatabase.saveTaskListToStorage(defaultTaskList);
      } catch (error) {
        expect(error, exception);
      }
    });
  });
}
