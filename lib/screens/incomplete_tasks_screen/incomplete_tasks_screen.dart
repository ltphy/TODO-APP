import 'package:flutter/material.dart';

import 'widgets/body.dart';

class IncompleteTasksScreen extends StatelessWidget {
  static const String routeName = "/incomplete-tasks";

  const IncompleteTasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}
