import 'package:flutter_test/flutter_test.dart';
import 'package:riyadh_metro/main.dart';
import 'package:flutter/material.dart';

void main() {
  testWidgets('MyApp loads and shows a widget', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.byType(MyApp), findsOneWidget);
  });
}
