import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:lab7/main.dart';

void main() {
  testWidgets('SignupScreen renders all required fields and submit button', (WidgetTester tester) async {
    // Build the app and trigger a frame
    await tester.pumpWidget(const SignupApp());

    // Verify AppBar title
    expect(find.text('Signup'), findsOneWidget);

    // Verify all input fields exist
    expect(find.widgetWithText(TextFormField, 'Full Name'), findsOneWidget);
    expect(find.widgetWithText(TextFormField, 'Email'), findsOneWidget);
    expect(find.widgetWithText(TextFormField, 'Password'), findsOneWidget);
    expect(find.widgetWithText(TextFormField, 'Confirm Password'), findsOneWidget);

    // Verify submit button exists
    expect(find.widgetWithText(ElevatedButton, 'Submit'), findsOneWidget);
  });
}
