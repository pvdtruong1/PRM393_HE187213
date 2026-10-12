import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lab5/main.dart';

void main() {
  testWidgets('Movie app navigation smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const MovieApp());

    // Verify Home Screen displays Movies title and Dune: Part Two
    expect(find.text('Movies'), findsOneWidget);
    expect(find.text('Dune: Part Two'), findsOneWidget);

    // Tap on the Dune card to navigate to detail screen
    await tester.tap(find.text('Dune: Part Two'));
    await tester.pumpAndSettle();

    // Verify we are on the Detail Screen
    expect(find.text('Overview'), findsNothing); // Overview heading is not there, but overview text is
    expect(find.text('Trailers'), findsOneWidget);
    expect(find.text('Official Trailer #1'), findsOneWidget);
    expect(find.text('Favorite'), findsOneWidget);

    // Tap back button
    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();

    // Verify back on Home Screen
    expect(find.text('Movies'), findsOneWidget);
    expect(find.text('Deadpool & Wolverine'), findsOneWidget);
  });
}
