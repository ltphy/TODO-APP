import 'package:flutter_test/flutter_test.dart';
import 'package:todo/model/task/task.dart';
import 'package:json_annotation/json_annotation.dart';

void main() {
  group('fromMap', () {
    test('task with all argument', () {
      final task = Task.fromJson({
        "id": "123",
        "isComplete": true,
        "description": "This a description",
        "name": "Name"
      });
      expect(
        task,
        Task(
            id: "123",
            isComplete: true,
            description: "This a description",
            name: "Name"),
      );
    });

    test('task without description and isComplete', () {
      final task = Task.fromJson({"id": "123", "name": "Name"});
      expect(
        task,
        Task(
          id: "123",
          isComplete: false,
          description: "",
          name: "Name",
        ),
      );
    });

    test('task without id and name', () {
      expect(() => Task.fromJson({"description": "This is a description"}),
          throwsA(const TypeMatcher<MissingRequiredKeysException>()));
    });

    test('empty object', () {
      expect(() => Task.fromJson({}),
          throwsA(const TypeMatcher<MissingRequiredKeysException>()));
    });
  });
  group('toMap', () {
    test('all properties are valid', () {
      final task = Task(
          name: 'abc',
          id: '123',
          description: 'this is description',
          isComplete: false);
      expect(task.toJson(), {
        "name": 'abc',
        "id": '123',
        "description": 'this is description',
        "isComplete": false
      });
    });

    test('task without description and isComplete', () {
      final task = Task(
        name: 'abc',
        id: '123',
      );
      expect(task.toJson(), {
        "name": 'abc',
        "id": '123',
        "description": '',
        "isComplete": false
      });
    });

  });
}
