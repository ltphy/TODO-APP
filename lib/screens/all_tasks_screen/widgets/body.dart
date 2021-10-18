import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/common_widgets/list_items_builder.dart';
import 'package:todo/common_widgets/task_item_builder.dart';
import 'package:todo/model/task/task.dart';
import 'package:todo/provider/task_list_provider.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskListProvider>(
      builder: (context, taskListProvider, _) {
        return Padding(
          padding: const EdgeInsets.all(8),
          child: ListItemsBuilder<Task>(
            items: taskListProvider.taskList,
            itemWidgetBuilder: (BuildContext context, Task task) =>
                TaskItemBuilder(task: task),
            content: 'Add new task to your TODO list',
          ),
        );
      },
    );
  }
}
