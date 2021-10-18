import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo/common_widgets/empty_container.dart';

void main() {
  group('empty container', () {
    testWidgets('empty container without field', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: EmptyContainer(),
      ));
      final titleFinder = find.text('Nothing here');
      final content = find.text('Add a new item to get started');
      expect(titleFinder, findsOneWidget);
      expect(content, findsOneWidget);
    });

    testWidgets('empty container without content', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: EmptyContainer(
          title: 'Add item',
          content: null,
        ),
      ));
      final titleFinder = find.byType(Text);
      expect(titleFinder, findsOneWidget);
    });
  });
}
