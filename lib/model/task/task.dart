import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'task.g.dart';

@JsonSerializable()
@HiveType(typeId: 0)
class Task extends HiveObject {
  @JsonKey(required: true)
  @HiveField(0)
  final String id;
  @JsonKey(required: true)
  @HiveField(1)
  final String name;
  @JsonKey(
    defaultValue: '',
  )
  @HiveField(2)
  String description;

  @JsonKey(defaultValue: false)
  @HiveField(3)
  bool isComplete;

  Task({
    required this.id,
    required this.name,
    this.description = '',
    this.isComplete = false,
  });

  factory Task.fromTask(Task task) {
    return Task(
      id: task.id,
      name: task.name,
      description: task.description,
      isComplete: task.isComplete,
    );
  }

  @override
  bool operator ==(other) {
    // same ref
    if (identical(other, this)) return true;
    if (runtimeType != other.runtimeType) return false;
    final Task otherTask = other as Task;
    return id == otherTask.id &&
        isComplete == otherTask.isComplete &&
        description == otherTask.description &&
        name == otherTask.name;
  }

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

  Map<String, dynamic> toJson() => _$TaskToJson(this);

  @override
  int get hashCode => hashValues(id, isComplete, description, name);

  @override
  String toString() =>
      'id: $id, name: $name, description: $description, isComplete: $isComplete';
}
