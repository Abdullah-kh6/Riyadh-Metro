import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:riyadh_metro/main.dart';

void main() {
  testWidgets('Riyadh Metro title is shown', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Riyadh Metro'), findsOneWidget);
    expect(find.text('Hello Metro'), findsOneWidget);
  });
}
