import 'package:flutter/material.dart';

import 'widgets/body.dart';


class CompleteTasksScreen extends StatelessWidget {
  static const String routeName = "/complete-tasks";

  const CompleteTasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}
