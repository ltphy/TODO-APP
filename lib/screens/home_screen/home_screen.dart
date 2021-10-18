import 'package:flutter/material.dart';
import 'package:todo/screens/all_tasks_screen/all_tasks_screen.dart';
import 'package:todo/screens/home_screen/widgets/custom_bottom_navigation_bar.dart';
import 'package:todo/service/notification_service.dart';

import '../../routes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  void initState() {
    NotificationService.instance.initContext(context);
    super.initState();
  }

  void _selectTab(int index) {
    if (_currentIndex == index) {
      // back to main screen when press on current tab item
      navigatorKey.currentState!.popUntil((route) => route.isFirst);
    } else {
      // pop all the way till first route
      if (navigatorKey.currentState!.canPop()) {
        navigatorKey.currentState!.popUntil((route) => route.isFirst);
      }
      // pop the current main and replace with the new route
      navigatorKey.currentState!
          .popAndPushNamed(RouteConfiguration.paths[index].route);
      setState(() => _currentIndex = index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // is first route in current Tab pop out
        // if not first route stop here
        return !await navigatorKey.currentState!.maybePop();
      },
      child: Scaffold(
        body: Navigator(
          key: navigatorKey,
          initialRoute: AllTasksScreen.routeName,
          onGenerateRoute: RouteConfiguration.onGenerateRoute,
        ),
        bottomNavigationBar: CustomBottomNavigationBar(
          selectTab: _selectTab,
          routeIndex: _currentIndex,
        ),
      ),
    );
  }
}
