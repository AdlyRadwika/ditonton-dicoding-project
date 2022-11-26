import 'package:ditonton/presentation/pages/about_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('should finds a stack widget or any other widgets', (tester) async {
    final stackWidget = find.byType(Stack);

    await tester.pumpWidget(MaterialApp(home: AboutPage(),));

    expect(stackWidget, findsWidgets);
  });

  testWidgets('should finds a widget using a Key', (tester) async {
    const testKey = Key('K');

    await tester.pumpWidget(MaterialApp(key: testKey, home: AboutPage()));

    expect(find.byKey(testKey), findsOneWidget);
  });
}