// Basic widget test for ResponsiveMovieApp
import 'package:flutter_test/flutter_test.dart';
import 'package:lab6/main.dart';

void main() {
  testWidgets('Renders ResponsiveMovieApp and displays title', (
    WidgetTester tester,
  ) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const ResponsiveMovieApp());

    // Verify that the title heading is displayed.
    expect(find.text('Find a Movie'), findsOneWidget);

    // Verify that the search field is present.
    expect(find.text('Search movies by title...'), findsOneWidget);
  });
}
