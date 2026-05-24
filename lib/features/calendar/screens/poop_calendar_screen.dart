import 'package:flutter/material.dart';

import '../../../app/feature_flags.dart';
import '../data/poop_log_repository.dart';
import '../models/poop_log.dart';
import '../../../shared/app_assets.dart';
import '../../../shared/date_helpers.dart';
import '../widgets/app_header.dart';
import '../widgets/bristol_section.dart';
import '../widgets/calendar_section.dart';
import '../widgets/mood_section.dart';
import '../widgets/notes_card.dart';
import '../widgets/poop_bottom_navigation.dart';
import '../widgets/progress_card.dart';
import '../widgets/selected_day_panel.dart';

class PoopCalendarScreen extends StatefulWidget {
  const PoopCalendarScreen({
    required this.repository,
    required this.featureFlags,
    super.key,
  });

  final PoopLogRepository repository;
  final FeatureFlags featureFlags;

  @override
  State<PoopCalendarScreen> createState() => _PoopCalendarScreenState();
}

class _PoopCalendarScreenState extends State<PoopCalendarScreen> {
  late DateTime _visibleMonth;
  late DateTime _selectedDay;
  late Stream<List<PoopLog>> _visibleMonthLogs;

  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    final DateTime today = DateTime.now();
    _visibleMonth = DateTime(today.year, today.month);
    _selectedDay = dateOnly(today);
    _visibleMonthLogs = widget.repository.watchLogsForMonth(_visibleMonth);
  }

  void _goToPreviousMonth() {
    setState(() {
      _visibleMonth = DateTime(_visibleMonth.year, _visibleMonth.month - 1);
      _selectedDay = _clampSelectedDayToVisibleMonth();
      _visibleMonthLogs = widget.repository.watchLogsForMonth(_visibleMonth);
    });
  }

  void _goToNextMonth() {
    setState(() {
      _visibleMonth = DateTime(_visibleMonth.year, _visibleMonth.month + 1);
      _selectedDay = _clampSelectedDayToVisibleMonth();
      _visibleMonthLogs = widget.repository.watchLogsForMonth(_visibleMonth);
    });
  }

  void _selectDay(DateTime day) {
    setState(() {
      _selectedDay = dateOnly(day);
      _visibleMonth = DateTime(day.year, day.month);
      _visibleMonthLogs = widget.repository.watchLogsForMonth(_visibleMonth);
    });
  }

  Future<void> _toggleSelectedDay(PoopLog? selectedLog) async {
    setState(() {
      _isSaving = true;
    });

    try {
      if (selectedLog == null) {
        await widget.repository.createLogForDay(_selectedDay);
      } else {
        await widget.repository.deleteLog(selectedLog.id);
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSaving = false;
        });
      }
    }
  }

  DateTime _clampSelectedDayToVisibleMonth() {
    final int lastDay = DateTime(
      _visibleMonth.year,
      _visibleMonth.month + 1,
      0,
    ).day;
    return DateTime(
      _visibleMonth.year,
      _visibleMonth.month,
      _selectedDay.day.clamp(1, lastDay),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: SafeArea(
        top: false,
        child: StreamBuilder<List<PoopLog>>(
          stream: _visibleMonthLogs,
          initialData: const <PoopLog>[],
          builder:
              (BuildContext context, AsyncSnapshot<List<PoopLog>> snapshot) {
                final List<PoopLog> logs = snapshot.data ?? const <PoopLog>[];
                final Set<DateTime> poopDays = logs
                    .map((PoopLog log) => dateOnly(log.occurredAt))
                    .toSet();
                final PoopLog? selectedLog = _logForDay(logs, _selectedDay);
                final bool selectedDayIsMarked = selectedLog != null;

                return Stack(
                  children: [
                    ListView(
                      padding: const EdgeInsets.fromLTRB(18, 0, 18, 118),
                      children: [
                        AppHeader(
                          onTodayPressed: () {
                            final DateTime today = DateTime.now();
                            setState(() {
                              _visibleMonth = DateTime(today.year, today.month);
                              _selectedDay = dateOnly(today);
                              _visibleMonthLogs = widget.repository
                                  .watchLogsForMonth(_visibleMonth);
                            });
                          },
                        ),
                        const SizedBox(height: 18),
                        CalendarSection(
                          visibleMonth: _visibleMonth,
                          selectedDay: _selectedDay,
                          poopDays: poopDays,
                          onPreviousMonth: _goToPreviousMonth,
                          onNextMonth: _goToNextMonth,
                          onDaySelected: _selectDay,
                        ),
                        const SizedBox(height: 16),
                        SelectedDayPanel(
                          day: _selectedDay,
                          log: selectedLog,
                          isMarked: selectedDayIsMarked,
                          monthLogCount: logs.length,
                          showStreak: widget.featureFlags.streaks,
                          onToggle: _isSaving
                              ? null
                              : () => _toggleSelectedDay(selectedLog),
                        ),
                        OptionalFeatureSections(
                          featureFlags: widget.featureFlags,
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: PoopBottomNavigation(
                        isLogged: selectedDayIsMarked,
                        onLogPressed: _isSaving || selectedDayIsMarked
                            ? null
                            : () => _toggleSelectedDay(null),
                      ),
                    ),
                  ],
                );
              },
        ),
      ),
    );
  }
}

class OptionalFeatureSections extends StatelessWidget {
  const OptionalFeatureSections({required this.featureFlags, super.key});

  final FeatureFlags featureFlags;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (featureFlags.bristol) ...[
          const SizedBox(height: 16),
          const BristolSection(),
        ],
        if (featureFlags.mood) ...[
          const SizedBox(height: 12),
          const MoodSection(),
        ],
        if (featureFlags.hasHealthProgress) ...[
          const SizedBox(height: 12),
          _HealthProgressRow(featureFlags: featureFlags),
        ],
        if (featureFlags.notes) ...[
          const SizedBox(height: 12),
          const NotesCard(),
        ],
      ],
    );
  }
}

class _HealthProgressRow extends StatelessWidget {
  const _HealthProgressRow({required this.featureFlags});

  final FeatureFlags featureFlags;

  @override
  Widget build(BuildContext context) {
    final List<Widget> cards = [
      if (featureFlags.hydration)
        const Expanded(
          child: ProgressCard(
            asset: AppAssets.hydrationDrop,
            title: 'Hydration',
            value: '6 / 8 cups',
            progress: 0.75,
            color: Color(0xFF22A9A4),
          ),
        ),
      if (featureFlags.hydration && featureFlags.fiber)
        const SizedBox(width: 10),
      if (featureFlags.fiber)
        const Expanded(
          child: ProgressCard(
            asset: AppAssets.fiberLeaf,
            title: 'Fiber',
            value: '18 / 25 g',
            progress: 0.72,
            color: Color(0xFF3F8E2E),
          ),
        ),
    ];

    return Row(children: cards);
  }
}

PoopLog? _logForDay(List<PoopLog> logs, DateTime day) {
  for (final PoopLog log in logs) {
    if (isSameDay(log.occurredAt, day)) {
      return log;
    }
  }

  return null;
}
