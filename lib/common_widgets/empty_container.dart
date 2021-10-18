import 'package:flutter/material.dart';

class EmptyContainer extends StatelessWidget {
  final String title;
  final String? content;

  const EmptyContainer({
    Key? key,
    this.title = 'Nothing here',
    this.content = 'Add a new item to get started',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(color: Colors.black54, fontSize: 30),
          ),
          if (content != null)
            Text(
              content!,
              style: const TextStyle(color: Colors.black54, fontSize: 20),
            ),
        ],
      ),
    );
  }
}
