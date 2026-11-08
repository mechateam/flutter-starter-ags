import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ags_flutter_starter/team_crud_template.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  testWidgets('Test Material 3 widgets: ChoiceChips, FilterChips, showDatePicker, and Badge', (WidgetTester tester) async {
    await tester.pumpWidget(const TeamApp());
    await tester.pumpAndSettle();

    // Enter name and login
    await tester.enterText(find.byType(TextFormField), 'Alex');
    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();

    // Verify initial badge count (2 starter items)
    expect(find.byType(Badge), findsOneWidget);

    // Test ChoiceChip selection (change from Priority to Review)
    final reviewChipFinder = find.widgetWithText(ChoiceChip, 'Review');
    expect(reviewChipFinder, findsOneWidget);
    await tester.tap(reviewChipFinder);
    await tester.pumpAndSettle();

    // Test DatePicker interaction
    final dateButtonFinder = find.byIcon(Icons.calendar_month);
    expect(dateButtonFinder, findsOneWidget);
    await tester.tap(dateButtonFinder);
    await tester.pumpAndSettle();

    // DatePicker dialog should be visible
    expect(find.byType(DatePickerDialog), findsOneWidget);
    // Tap 'OK'
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();

    // Add item with new category and date
    await tester.enterText(find.byType(TextField), 'Prepare Week 16 Deliverables');
    await tester.tap(find.widgetWithText(ElevatedButton, 'Add Task'));
    await tester.pumpAndSettle();

    expect(find.text('Prepare Week 16 Deliverables'), findsOneWidget);
    expect(find.text('Review'), findsWidgets);

    // Test FilterChips: Filter by 'Completed'
    final completedFilterChip = find.widgetWithText(FilterChip, 'Completed');
    await tester.tap(completedFilterChip);
    await tester.pumpAndSettle();

    // None are completed yet, so list should be empty
    expect(find.text('No tasks match the filter.'), findsOneWidget);

    // Filter by 'Active'
    final activeFilterChip = find.widgetWithText(FilterChip, 'Active');
    await tester.tap(activeFilterChip);
    await tester.pumpAndSettle();
    expect(find.text('Prepare Week 16 Deliverables'), findsOneWidget);

    // Filter by 'All'
    final allFilterChip = find.widgetWithText(FilterChip, 'All');
    await tester.tap(allFilterChip);
    await tester.pumpAndSettle();
    expect(find.text('Prepare Week 16 Deliverables'), findsOneWidget);
  });
}
