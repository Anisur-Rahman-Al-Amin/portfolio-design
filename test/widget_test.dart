import 'package:flutter_test/flutter_test.dart';

import 'package:my_portfolio_web/main.dart';

void main() {
  testWidgets('shows the portfolio hero and key sections', (tester) async {
    await tester.pumpWidget(const PersonalPortfolioApp());

    expect(find.text('Anisur Rahman'), findsOneWidget);
    expect(find.text('About me'), findsOneWidget);
    expect(find.text('Featured work'), findsOneWidget);
    expect(find.text('Let’s work together'), findsOneWidget);
  });

  testWidgets('scrolls to the project section from the nav action', (tester) async {
    await tester.pumpWidget(const PersonalPortfolioApp());

    await tester.tap(find.text('Projects'));
    await tester.pumpAndSettle();

    expect(find.text('Featured work'), findsOneWidget);
  });
}
