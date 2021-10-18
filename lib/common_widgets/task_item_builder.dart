import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/model/task/task.dart';
import 'package:todo/provider/task_list_provider.dart';
import 'package:todo/screens/update_task_screen/update_task_screen.dart';

class TaskItemBuilder extends StatelessWidget {
  final Task task;

  const TaskItemBuilder({Key? key, required this.task}) : super(key: key);

  Future<void> selectTask(BuildContext context) async {
    await context.read<TaskListProvider>().selectTask(task);
  }

  Future<void> removeTask(BuildContext context) async {
    await context.read<TaskListProvider>().removeTask(task);
  }

  Future<void> editTask(BuildContext context) async {
    // use global nav
    await context
        .read<NavigatorState>()
        .pushNamed(UpdateTaskScreen.routeName, arguments: task);
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      background: Container(color: Colors.red),
      key: ValueKey(task.id),
      direction: DismissDirection.endToStart,
      onDismissed: (DismissDirection dismissDirection) => removeTask(context),
      child: InkWell(
        onTap: () => editTask(context),
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: ListTile(
            title: Text(task.name),
            subtitle: task.description.isEmpty
                ? null
                : Text(
                    task.description,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
            leading: Checkbox(
              onChanged: (bool? value) => selectTask(context),
              value: task.isComplete,
            ),
          ),
        ),
      ),
    );
  }
}
