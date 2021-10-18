import 'package:flutter/material.dart';
import 'package:todo/screens/all_tasks_screen/widgets/add_task_button.dart';

import '../all_tasks_screen/widgets/body.dart';

class AllTasksScreen extends StatelessWidget {
  static const String routeName = "/";

  const AllTasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Body(),
      floatingActionButton: AddTaskButton(),
    );
  }
}
