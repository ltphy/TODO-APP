import 'package:flutter/material.dart';

import 'empty_container.dart';

typedef ItemWidgetBuilder<T> = Widget Function(BuildContext context, T value);

class ListItemsBuilder<T> extends StatelessWidget {
  final ItemWidgetBuilder<T> itemWidgetBuilder;
  final List<T> items;
  final String? content;

  const ListItemsBuilder({
    Key? key,
    required this.itemWidgetBuilder,
    required this.items,
    this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (items.isNotEmpty) {
      return buildList(items);
    }
    return EmptyContainer(
      content: content,
      title: 'No Item',
    );
  }

  Widget buildList(List<T> items) {
    return ListView.separated(
      itemCount: items.length,
      itemBuilder: (context, index) => itemWidgetBuilder(context, items[index]),
      separatorBuilder: (BuildContext context, int index) {
        return const Divider(
          height: 0.5,
        );
      },
    );
  }
}
