// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:my_portfolio_web/main.dart';

void main() {
  testWidgets('shows work and filters projects by category', (tester) async {
    await tester.pumpWidget(const PortfolioApp());

    expect(find.text('Hello, I’m\nAnisur.'), findsOneWidget);
    expect(find.text('Digital product experiments'), findsOneWidget);

    await tester.ensureVisible(find.byType(DropdownButton<String>));
    await tester.tap(find.byType(DropdownButton<String>));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Development').last);
    await tester.pumpAndSettle();

    expect(find.text('Digital product experiments'), findsOneWidget);
    expect(find.text('Web experience concepts'), findsNothing);
  });

  testWidgets('validates and submits the contact form', (tester) async {
    await tester.pumpWidget(const PortfolioApp());
    await tester.tap(find.byIcon(Icons.mail_outline));
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.text('Send message'));
    await tester.tap(find.text('Send message'));
    await tester.pump();
    expect(find.text('Please add your name'), findsOneWidget);

    await tester.enterText(
      find.widgetWithText(TextFormField, 'Your name'),
      'Mina',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Email address'),
      'mina@example.com',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'What can I help with?'),
      'A new product',
    );
    await tester.ensureVisible(find.text('Send message'));
    await tester.tap(find.text('Send message'));
    await tester.pump();

    expect(find.text('Thanks, I will be in touch soon.'), findsOneWidget);
  });

  testWidgets('opens sign up and shows the member avatar after signup', (
    tester,
  ) async {
    await tester.pumpWidget(const PortfolioApp());

    await tester.tap(find.text('Sign up'));
    await tester.pumpAndSettle();
    expect(find.text('Stay connected'), findsOneWidget);
    expect(find.text('Create account'), findsOneWidget);

    await tester.enterText(
      find.widgetWithText(TextFormField, 'Full name'),
      'Mina',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Email address'),
      'mina@example.com',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Password'),
      'secret123',
    );
    await tester.tap(find.text('Create account'));
    await tester.pumpAndSettle();

    expect(find.text('M'), findsOneWidget);
    expect(find.text('Sign up'), findsNothing);
  });
}
