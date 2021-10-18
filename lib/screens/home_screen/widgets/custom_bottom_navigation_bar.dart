import 'package:flutter/material.dart';
import 'package:todo/common_widgets/destination.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int routeIndex;
  final ValueSetter<int> selectTab;

  const CustomBottomNavigationBar({
    Key? key,
    required this.routeIndex,
    required this.selectTab,
  }) : super(key: key);

  BottomNavigationBarItem buildBottomBarItem(Destination destinationItem) {
    return BottomNavigationBarItem(
      icon: Icon(destinationItem.iconData),
      label: destinationItem.name,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: routeIndex,
      onTap: selectTab,
      items: [
        for (int i = 0; i < destinationList.length; i++)
          buildBottomBarItem(destinationList[i])
      ],
    );
  }
}
