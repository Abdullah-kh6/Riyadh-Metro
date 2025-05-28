import 'package:flutter_test/flutter_test.dart';
import 'package:riyadh_metro/main.dart';

void main() {
  testWidgets('MyApp renders', (tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.byType(MyApp), findsOneWidget);
  });
}
