import 'package:flutter/material.dart';
import 'package:todo/screens/update_task_screen/update_task_screen.dart';
import 'package:provider/provider.dart';

class AddTaskButton extends StatelessWidget {
  const AddTaskButton({Key? key}) : super(key: key);

  Future<void> addTask(BuildContext context) async {
    // use global nav
    await context.read<NavigatorState>().pushNamed(UpdateTaskScreen.routeName);
    // await Navigator.of(context).pushNamed(UpdateTaskScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async => await addTask(context),
      child: const Center(
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }
}
