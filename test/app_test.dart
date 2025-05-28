import 'package:riyadh_metro/payment/payment222/payment222_model.dart';
import 'package:riyadh_metro/payment/p_a_y_m_e_n_t2_copy/p_a_y_m_e_n_t2_copy_model.dart';
import 'package:riyadh_metro/payment/p_a_y_m_e_n_t2_copy2/p_a_y_m_e_n_t2_copy2_model.dart';
import 'package:mime/mime.dart'; // For `mime()`
import 'package:flutter_test/flutter_test.dart';
import 'package:riyadh_metro/main.dart';
import 'package:flutter/material.dart';

void main() {
  testWidgets('MyApp loads and shows a widget', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.byType(MyApp), findsOneWidget);
  });
}
