import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/common_widgets/custom_progress_indicator.dart';
import 'package:todo/model/task/task.dart';
import 'package:todo/provider/selected_task_provider.dart';
import 'package:todo/provider/task_list_provider.dart';
import 'package:todo/service/notification_service.dart';
import 'widgets/body.dart';

class UpdateTaskScreen extends StatelessWidget {
  static const String routeName = "/update-task-screen";
  final Task? task;
  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  static Future<void> show(BuildContext context, {Task? task}) async {
    await Navigator.of(context)
        .pushNamed(UpdateTaskScreen.routeName, arguments: task);
  }

  const UpdateTaskScreen({this.task, Key? key}) : super(key: key);

  Future<void> updateTask(BuildContext context) async {
    try {
      if (formKey.currentState!.validate()) {
        formKey.currentState!.save();
        await context.read<SelectedTaskProvider>().updateSelectedTask();
        Navigator.of(context).pop();
        NotificationService.instance
            .showSuccess(context.read<SelectedTaskProvider>().successMessage);
      }
    } catch (error) {
      Navigator.of(context).pop();
      NotificationService.instance
          .showFail(context.read<SelectedTaskProvider>().failMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SelectedTaskProvider>(
          create: (context) => SelectedTaskProvider(
            taskListProvider:
                Provider.of<TaskListProvider>(context, listen: false),
            task: task,
            description: task?.description ?? '',
            name: task?.name ?? '',
          ),
        )
      ],
      child: Scaffold(
        body: Body(
          taskUpdateFunction: updateTask,
        ),
        appBar: AppBar(
          // does not allow while loading
          leading: Builder(builder: (context) {
            return IconButton(
              disabledColor: Colors.white,
              icon: const Icon(Icons.close),
              onPressed: context.select<SelectedTaskProvider, bool>(
                      (SelectedTaskProvider selectTaskProvider) =>
                          selectTaskProvider.loading)
                  ? null
                  : () => Navigator.of(context).pop(),
            );
          }),
          title: Text(
            task != null ? 'Update task' : 'Add task',
            style: Theme.of(context).primaryTextTheme.headline6,
          ),
          actions: [
            Builder(
              builder: (BuildContext context) {
                return !context.select<SelectedTaskProvider, bool>(
                        (SelectedTaskProvider selectTaskProvider) =>
                            selectTaskProvider.loading)
                    ? TextButton(
                        onPressed: () => updateTask(context),
                        child: Text(
                          'Done',
                          style: Theme.of(context).primaryTextTheme.bodyText1,
                        ),
                      )
                    : const Center(
                        child: CustomProgressIndicator(
                          color: Colors.white,
                        ),
                      );
              },
            ),
          ],
        ),
      ),
    );
  }
}
