import 'package:flutter/material.dart';
import 'package:todo/screens/all_tasks_screen/all_tasks_screen.dart';
import 'package:todo/screens/complete_tasks_screen/complete_tasks_screen.dart';
import 'package:todo/screens/incomplete_tasks_screen/incomplete_tasks_screen.dart';
import 'package:todo/screens/update_task_screen/update_task_screen.dart';

import 'model/task/task.dart';

typedef PathWidgetBuilder = Widget Function(
    BuildContext context, RouteSettings settings);

class Path {
  final String route;
  final PathWidgetBuilder builder;

  Path({
    required this.route,
    required this.builder,
  });
}

class RouteConfiguration {
  static final List<Path> paths = [
    Path(
      route: AllTasksScreen.routeName,
      builder: (context, settings) {
        return const AllTasksScreen();
      },
    ),
    Path(
      route: CompleteTasksScreen.routeName,
      builder: (context, settings) {
        return const CompleteTasksScreen();
      },
    ),
    Path(
      route: IncompleteTasksScreen.routeName,
      builder: (context, settings) {
        return const IncompleteTasksScreen();
      },
    ),
  ];
  static final List<Path> mainPaths = [
    Path(
      route: UpdateTaskScreen.routeName,
      builder: (context, settings) {
        Task? argument = settings.arguments as Task?;
        return UpdateTaskScreen(
          task: argument,
        );
      },
    ),
  ];

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    for (Path path in paths) {
      if (path.route == settings.name) {
        return MaterialPageRoute(
          builder: (context) {
            return path.builder(context, settings);
          },
          settings: settings,
        );
      }
    }
    throw Exception('Invalid route ${settings.name}');
  }

  static Route<dynamic> onGenerateMainRoute(RouteSettings settings) {
    for (Path path in mainPaths) {
      if (path.route == settings.name) {
        return MaterialPageRoute(
          builder: (context) {
            return path.builder(context, settings);
          },
          settings: settings,
        );
      }
    }
    throw Exception('Invalid route ${settings.name}');
  }
}
