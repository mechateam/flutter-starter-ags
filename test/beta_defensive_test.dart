import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ags_flutter_starter/team_crud_template.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  group('Week 17 Version Beta Quality Assurance & Defensive UI Tests', () {
    testWidgets('1. Defensive Input: Reject blank task input and preserve list count', (WidgetTester tester) async {
      await tester.pumpWidget(const TeamApp());
      await tester.pumpAndSettle();

      // Login to Dashboard
      await tester.enterText(find.byType(TextFormField), 'Tester');
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      final initialCardCount = find.byType(Card).evaluate().length;

      // Attempt to add empty string
      final inputFinder = find.byType(TextField);
      await tester.enterText(inputFinder, '   ');
      await tester.tap(find.widgetWithText(ElevatedButton, 'Add Task'));
      await tester.pumpAndSettle();

      // Card count should not change
      final afterCardCount = find.byType(Card).evaluate().length;
      expect(afterCardCount, equals(initialCardCount));
    });

    testWidgets('2. Defensive UI: Long description (150 chars) renders without RenderFlex overflow', (WidgetTester tester) async {
      await tester.pumpWidget(const TeamApp());
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextFormField), 'StressTester');
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      const longText = 'This is an extremely long task description intended to test text wrapping and ensure that cards expand vertically without causing RenderFlex overflow errors on small screens.';
      final inputFinder = find.byType(TextField);
      await tester.enterText(inputFinder, longText);
      await tester.tap(find.widgetWithText(ElevatedButton, 'Add Task'));
      await tester.pumpAndSettle();

      expect(find.text(longText), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('3. Cold Start Resilience: App starts cleanly with null preferences', (WidgetTester tester) async {
      SharedPreferences.setMockInitialValues({});
      await tester.pumpWidget(const TeamApp());
      await tester.pumpAndSettle();

      // Should default to WelcomeScreen shell without throwing null pointer error
      expect(find.text('Welcome to Your Team App'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  });
}
