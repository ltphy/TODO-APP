import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';
import 'package:todo/assets/constants.dart';

import 'common_widgets/custom_progress_indicator.dart';
import 'model/task/task.dart';
import 'provider/task_list_provider.dart';
import 'routes.dart';
import 'screens/home_screen/home_screen.dart';
import 'service/storage_database.dart';

Future<void> main() async {
  // import path provider because Hive needs a home directory to initialize
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final LocalStorage storage = LocalStorage(logsFile);
  late final StorageDatabase storageDatabase;

  // Future<List<Task>> loadData() async {
  //   await storage.ready;
  //   return storageDatabase.getTaskListFromStorage();
  // }

  Future<void> loadData() async {
    await Future.wait([Hive.openBox<Task>(tasksKey)]);
  }

  @override
  void initState() {
    storageDatabase = StorageDatabase(localStorage: storage);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loadData(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.error != null) {
            return MaterialApp(
              home: Scaffold(
                body: Center(
                  child: Text(snapshot.error.toString(),
                      style: Theme.of(context).textTheme.headline5),
                ),
              ),
            );
          }
          print('boxes ${Hive.box<Task>(tasksKey).values}');
          return MultiProvider(
            providers: [
              ChangeNotifierProvider<TaskListProvider>(
                create: (context) => TaskListProvider(
                  taskList: Hive.box<Task>(tasksKey).values.toList(),
                  storageDatabase: StorageHiveDatabase(),
                ),
              ),
            ],
            child: MaterialApp(
              title: 'TODO',
              home: Provider<NavigatorState>(
                create: (context) => Navigator.of(context),
                child: const HomeScreen(),
              ),
              onGenerateRoute: RouteConfiguration.onGenerateMainRoute,
            ),
          );
        }
        return const MaterialApp(
          home: Scaffold(
            body: Center(
              child: CustomProgressIndicator(),
            ),
          ),
        );
      },
    );
  }
}
