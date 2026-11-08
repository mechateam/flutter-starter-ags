import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ags_flutter_starter/team_crud_template.dart';

void main() {
  testWidgets('DashboardScreen initialUserName fallback and starter items immutability', (WidgetTester tester) async {
    // Test that passing initialUserName populates greeting even if SharedPreferences is empty
    SharedPreferences.setMockInitialValues({});

    await tester.pumpWidget(
      const MaterialApp(
        home: DashboardScreen(initialUserName: 'FallbackUser'),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Logged In: FallbackUser'), findsOneWidget);

    // Verify mutating an item does not corrupt defaultStarterItems
    final checkbox = find.byType(Checkbox).first;
    await tester.tap(checkbox);
    await tester.pumpAndSettle();

    // defaultStarterItems first element should remain uncompleted
    expect(defaultStarterItems.first.isCompleted, isFalse);
  });
}
