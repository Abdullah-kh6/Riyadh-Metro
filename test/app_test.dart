import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riyadh_metro/main.dart';

void main() {
  testWidgets('Riyadh Metro app launches correctly', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // Confirm app launched by finding MaterialApp or home widget
    expect(find.byType(MyApp), findsOneWidget);
  });
}
