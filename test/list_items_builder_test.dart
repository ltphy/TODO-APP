import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo/common_widgets/empty_container.dart';
import 'package:todo/common_widgets/list_items_builder.dart';

void main() {
  group('list items builder', () {
    testWidgets('empty container from list', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Builder(
          builder: (context) {
            return ListItemsBuilder<String>(
              itemWidgetBuilder: (context, String value) => Text(value),
              items: const [],
            );
          },
        ),
      ));
      final emptyContainer = find.byType(EmptyContainer);
      expect(emptyContainer, findsOneWidget);
    });
    testWidgets('list items', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Builder(
          builder: (context) {
            return ListItemsBuilder<String>(
              itemWidgetBuilder: (context, String value) => Text(value),
              items: const ['name', 'value'],
            );
          },
        ),
      ));
      final listContainer = find.byType(ListView);
      expect(listContainer, findsOneWidget);
    });
  });
}
