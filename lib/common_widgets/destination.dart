import 'package:flutter/material.dart';

class Destination {
  final String name;
  final IconData iconData;

  Destination({required this.name, required this.iconData});
}

List<Destination> destinationList = [
  Destination(name: 'All', iconData: Icons.task),
  Destination(name: 'Complete', iconData: Icons.check),
  Destination(name: 'Incomplete', iconData: Icons.close),
];
