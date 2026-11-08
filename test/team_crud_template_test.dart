import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ags_flutter_starter/team_crud_template.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  testWidgets('Strategy 2 Full UI Flow: WelcomeScreen shell to DashboardScreen core engine', (WidgetTester tester) async {
    // 1. Build TeamApp
    await tester.pumpWidget(const TeamApp());
    await tester.pumpAndSettle();

    // Verify WelcomeScreen elements
    expect(find.text('Welcome to Your Team App'), findsOneWidget);
    expect(find.byType(TextFormField), findsOneWidget);

    // 2. Validate empty input triggers validation error
    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();
    expect(find.text('Please enter your name to proceed.'), findsOneWidget);

    // 3. Enter student name and submit
    await tester.enterText(find.byType(TextFormField), 'Meldi');
    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();

    // 4. Verify WelcomeScreen is replaced and DashboardScreen is active
    expect(find.text('Welcome to Your Team App'), findsNothing);
    expect(find.text('Logged In: Meldi'), findsOneWidget);

    // 5. Verify starter items exist
    expect(find.text('Review Flutter sprint slides'), findsOneWidget);
    expect(find.text('Prepare team project demo'), findsOneWidget);

    // 6. Test Create: Add a new item
    final inputFinder = find.byType(TextField);
    expect(inputFinder, findsOneWidget);
    await tester.enterText(inputFinder, 'Test New Item');
    await tester.tap(find.widgetWithText(ElevatedButton, 'Add Task'));
    await tester.pumpAndSettle();

    expect(find.text('Test New Item'), findsOneWidget);

    // 7. Test Toggle completion
    final checkboxFinder = find.byType(Checkbox).first;
    await tester.tap(checkboxFinder);
    await tester.pumpAndSettle();

    // 8. Test Delete item
    final initialCount = find.byType(Card).evaluate().length;
    final deleteButtonFinder = find.byIcon(Icons.delete_outline).first;
    await tester.tap(deleteButtonFinder);
    await tester.pumpAndSettle();

    final afterDeleteCount = find.byType(Card).evaluate().length;
    expect(afterDeleteCount, equals(initialCount - 1));

    // 9. Test Switch user (logout to shell)
    final logoutButton = find.byIcon(Icons.logout);
    await tester.tap(logoutButton);
    await tester.pumpAndSettle();

    expect(find.text('Welcome to Your Team App'), findsOneWidget);
  });
}
