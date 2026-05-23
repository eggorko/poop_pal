import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:drift/native.dart';
import 'package:pt/app/poop_tracker_app.dart';
import 'package:pt/features/calendar/data/app_database.dart';
import 'package:pt/features/calendar/data/poop_log_repository.dart';

void main() {
  testWidgets('marks and removes the selected poop day', (
    WidgetTester tester,
  ) async {
    final AppDatabase database = AppDatabase(NativeDatabase.memory());
    final PoopLogRepository repository = PoopLogRepository(database);
    addTearDown(repository.close);

    await tester.pumpWidget(PoopTrackerApp(repository: repository));

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
    expect(find.text('Poop logged 🎉'), findsNothing);
    expect(find.text('Time of logging'), findsNothing);

    await tester.tap(find.text('Log poop'));
    await tester.pumpAndSettle();

    expect(find.text('1 poop days'), findsOneWidget);
    expect(find.text('Logged'), findsOneWidget);
    expect(find.text('Poop logged 🎉'), findsOneWidget);
    expect(find.text('Time of logging'), findsOneWidget);
    expect(find.byIcon(Icons.check_circle), findsOneWidget);

    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump(const Duration(milliseconds: 1));
    await tester.pumpWidget(PoopTrackerApp(repository: repository));
    await tester.scrollUntilVisible(
      find.text('Logged'),
      300,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.pumpAndSettle();

    expect(find.text('1 poop days'), findsOneWidget);
    expect(find.text('Logged'), findsOneWidget);
    expect(find.text('Poop logged 🎉'), findsOneWidget);
    expect(find.text('Time of logging'), findsOneWidget);

    await tester.tap(find.text('Logged'));
    await tester.pumpAndSettle();

    expect(find.text('0 poop days'), findsOneWidget);
    expect(find.text('Log poop'), findsOneWidget);
    expect(find.text('Poop logged 🎉'), findsNothing);
    expect(find.text('Time of logging'), findsNothing);

    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump(const Duration(milliseconds: 1));
  });
}
