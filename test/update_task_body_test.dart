import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:todo/provider/selected_task_provider.dart';
import 'package:todo/screens/update_task_screen/widgets/body.dart';

import 'update_task_body_test.mocks.dart';

@GenerateMocks([SelectedTaskProvider])
void main() {
  late MockSelectedTaskProvider mockSelectedTaskProvider;
  setUp(() {
    mockSelectedTaskProvider = MockSelectedTaskProvider();
  });

  Future<void> pumpUpdateTaskBody(WidgetTester tester,
      {required TaskUpdateFunction taskUpdateFunction}) async {
    await tester.pumpWidget(
      ChangeNotifierProvider<SelectedTaskProvider>.value(
        value: mockSelectedTaskProvider,
        child: MaterialApp(
          home: Scaffold(
            body: Body(
              taskUpdateFunction: taskUpdateFunction,
            ),
          ),
        ),
      ),
    );
  }

  stubNameAndDescription() {
    when(mockSelectedTaskProvider.description).thenReturn('');
    when(mockSelectedTaskProvider.name).thenReturn('');
    when(mockSelectedTaskProvider.loading).thenReturn(false);
  }

  group('update task body', () {
    testWidgets(
        'WHEN user enters name and description'
        'and Press Done keyword on keyboard'
        'The updateTask is called'
        'Validate form key successfully'
        'Save the descriptoin and name value'
        , (WidgetTester tester) async {
      var updateTask = false;
      stubNameAndDescription();

      await pumpUpdateTaskBody(tester, taskUpdateFunction: (context) async {
        updateTask = true;
      });
      const taskName = 'task name';
      const description = 'This is a description';

      // the name field
      final nameField = find.byKey(const Key('name'));
      expect(nameField, findsOneWidget);
      // type the text to field
      await tester.enterText(nameField, taskName);

      final descriptionField = find.byKey(const Key('description'));
      expect(descriptionField, findsOneWidget);
      await tester.enterText(descriptionField, description);
      // after press done check validation
      await tester.testTextInput.receiveAction(TextInputAction.done);
      // find by form
      Finder formWidgetFinder = find.byType(Form);
      Form formWidget = tester.widget(formWidgetFinder) as Form;

      GlobalKey<FormState> formKey = formWidget.key as GlobalKey<FormState>;
      expect(formKey.currentState!.validate(), true);

      formKey.currentState!.save();
      verify(mockSelectedTaskProvider.updateTask(name: taskName)).called(1);
      verify(mockSelectedTaskProvider.updateTask(description: description)).called(1);

      expect(updateTask, true);
    });

    testWidgets(
        'WHEN the name field is empty'
        'Press Done keyword on keyboard'
        'Validate return fail', (WidgetTester tester) async {
      var updateTask = false;
      stubNameAndDescription();

      await pumpUpdateTaskBody(tester, taskUpdateFunction: (context) async {
        updateTask = true;
      });
      const taskName = '';
      const description = 'This is a description';

      // the name field
      final nameField = find.byKey(const Key('name'));
      expect(nameField, findsOneWidget);
      // type the text to field
      await tester.enterText(nameField, taskName);

      final descriptionField = find.byKey(const Key('description'));
      expect(descriptionField, findsOneWidget);
      await tester.enterText(descriptionField, description);
      // after press done check validation
      await tester.testTextInput.receiveAction(TextInputAction.done);
      // find by form
      Finder formWidgetFinder = find.byType(Form);
      Form formWidget = tester.widget(formWidgetFinder) as Form;

      GlobalKey<FormState> formKey = formWidget.key as GlobalKey<FormState>;
      expect(formKey.currentState!.validate(), false);

      expect(updateTask, true);
    });
  });
}
