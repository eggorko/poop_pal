import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:drift/native.dart';
import 'package:pt/app/feature_flags.dart';
import 'package:pt/app/poop_tracker_app.dart';
import 'package:pt/features/calendar/data/app_database.dart';
import 'package:pt/features/calendar/data/poop_log_repository.dart';
import 'package:pt/features/calendar/screens/poop_calendar_screen.dart';
import 'package:pt/features/calendar/widgets/poop_bottom_navigation.dart';
import 'package:pt/features/calendar/widgets/selected_day_panel.dart';

void main() {
  testWidgets('marks and removes the selected poop day', (
    WidgetTester tester,
  ) async {
    final AppDatabase database = AppDatabase(NativeDatabase.memory());
    final PoopLogRepository repository = PoopLogRepository(database);
    addTearDown(repository.close);

    await tester.pumpWidget(PoopTrackerApp(repository: repository));

    expect(find.text('Poop Pal'), findsOneWidget);
    expect(find.text('Calendar'), findsNothing);
    expect(find.text('History'), findsNothing);
    expect(find.text('Insights'), findsNothing);
    expect(find.text('Profile'), findsNothing);

    await tester.scrollUntilVisible(
      find.text('Log poop'),
      300,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.pumpAndSettle();

    expect(find.text('Log poop'), findsOneWidget);
    expect(find.text('Streak'), findsNothing);
    expect(find.text('Bristol'), findsNothing);
    expect(find.text('After Poop Mood'), findsNothing);
    expect(find.text('Hydration'), findsNothing);
    expect(find.text('Fiber'), findsNothing);
    expect(find.text('Notes'), findsNothing);
    expect(find.text('Poop logged 🎉'), findsNothing);
    expect(find.text('Time'), findsNothing);

    await tester.tap(find.byTooltip('Log poop'));
    await tester.pumpAndSettle();

    expect(find.text('Logged'), findsOneWidget);
    expect(find.text('Poop logged 🎉'), findsOneWidget);
    expect(find.text('Time'), findsOneWidget);
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

    expect(find.text('Logged'), findsOneWidget);
    expect(find.text('Poop logged 🎉'), findsOneWidget);
    expect(find.text('Time'), findsOneWidget);

    await tester.tap(find.text('Logged'));
    await tester.pumpAndSettle();

    expect(find.text('Log poop'), findsOneWidget);
    expect(find.text('Poop logged 🎉'), findsNothing);
    expect(find.text('Time'), findsNothing);

    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump(const Duration(milliseconds: 1));
  });

  testWidgets('can show placeholder sections when feature flags are enabled', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                SelectedDayPanel(
                  day: DateTime(2026, 5, 20),
                  log: null,
                  isMarked: false,
                  monthLogCount: 7,
                  showStreak: true,
                  onToggle: null,
                ),
                const OptionalFeatureSections(
                  featureFlags: FeatureFlags.allEnabled(),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Streak'), findsOneWidget);
    expect(find.text('Bristol'), findsOneWidget);
    expect(find.text('After Poop Mood', skipOffstage: false), findsOneWidget);
    expect(find.text('Hydration', skipOffstage: false), findsOneWidget);
    expect(find.text('Fiber', skipOffstage: false), findsOneWidget);
    expect(find.text('Notes', skipOffstage: false), findsOneWidget);
  });

  testWidgets('can show unfinished navigation items when enabled', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: PoopBottomNavigation(
            isLogged: false,
            featureFlags: FeatureFlags.allEnabled(),
            onLogPressed: null,
          ),
        ),
      ),
    );

    expect(find.text('Calendar'), findsOneWidget);
    expect(find.text('History'), findsOneWidget);
    expect(find.text('Insights'), findsOneWidget);
    expect(find.text('Profile'), findsOneWidget);
  });
}
