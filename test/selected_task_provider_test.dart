import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:todo/provider/selected_task_provider.dart';
import 'package:todo/provider/task_list_provider.dart';

import 'selected_task_provider_test.mocks.dart';

@GenerateMocks([TaskListProvider])
void main() {
  late SelectedTaskProvider selectedTaskProvider;
  final MockTaskListProvider mockTaskListProvider = MockTaskListProvider();
  setUp(() {
    selectedTaskProvider = SelectedTaskProvider(
      taskListProvider: mockTaskListProvider,
      description: 'default_description',
      name: 'default_name',
    );
  });

  test('update selected task to storage successfully', () async {
    var didNotifyListeners = false;
    selectedTaskProvider.addListener(() => didNotifyListeners = true);

    await selectedTaskProvider.updateSelectedTask();
    verify(mockTaskListProvider.updateTask(any)).called(1);
    expect(didNotifyListeners, true);
  });

  test('save description and still keep name field', () {
    const description = 'description';
    selectedTaskProvider.updateTask(description: description);
    expect(selectedTaskProvider.description, description);
    expect(selectedTaskProvider.name, 'default_name');
  });

  test('save name', () {
    const name = 'name';
    selectedTaskProvider.updateTask(name: name);
    expect(selectedTaskProvider.description, 'default_description');
    expect(selectedTaskProvider.name, name);
  });
}
