import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio/main.dart';

void main() {
  testWidgets('Portfolio app launches and shows Hero section',
      (WidgetTester tester) async {
    await tester.pumpWidget(const PortfolioApp());
    await tester.pump(const Duration(seconds: 1));
    expect(find.text('Parth'), findsWidgets);
  });
}
