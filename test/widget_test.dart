import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:pt/app/poop_tracker_app.dart';

void main() {
  testWidgets('marks and removes the selected poop day', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const PoopTrackerApp());

    expect(find.text('PoopPal'), findsOneWidget);
    expect(find.text('Calendar'), findsOneWidget);

    await tester.scrollUntilVisible(
      find.text('Log poop'),
      300,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.pumpAndSettle();

    expect(find.text('0 poop days'), findsOneWidget);
    expect(find.text('Log poop'), findsOneWidget);

    await tester.tap(find.text('Log poop'));
    await tester.pumpAndSettle();

    expect(find.text('1 poop days'), findsOneWidget);
    expect(find.text('Logged'), findsOneWidget);
    expect(find.byIcon(Icons.check_circle), findsOneWidget);

    await tester.tap(find.text('Logged'));
    await tester.pumpAndSettle();

    expect(find.text('0 poop days'), findsOneWidget);
    expect(find.text('Log poop'), findsOneWidget);
  });
}
