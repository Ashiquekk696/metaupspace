import 'package:flutter_test/flutter_test.dart';
import 'package:metaupspace/app.dart';

void main() {
  testWidgets('login surface renders', (WidgetTester tester) async {
    await tester.pumpWidget(const MetaApp());
    await tester.pumpAndSettle();
    expect(find.text('Metaupspace'), findsOneWidget);
    expect(find.text('Continue'), findsOneWidget);
  });
}
