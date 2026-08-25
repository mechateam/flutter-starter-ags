import 'package:flutter_test/flutter_test.dart';

import 'package:ags_flutter_starter/main.dart';

void main() {
  testWidgets('KantinKu smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that KantinKu title renders in AppBar.
    expect(find.text('KantinKu'), findsOneWidget);
  });
}
