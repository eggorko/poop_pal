import 'package:flutter/material.dart';

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
  const PoopCalendarScreen({super.key});

  @override
  State<PoopCalendarScreen> createState() => _PoopCalendarScreenState();
}

class _PoopCalendarScreenState extends State<PoopCalendarScreen> {
  final Set<DateTime> _poopDays = <DateTime>{};

  late DateTime _visibleMonth;
  late DateTime _selectedDay;

  @override
  void initState() {
    super.initState();
    final DateTime today = DateTime.now();
    _visibleMonth = DateTime(today.year, today.month);
    _selectedDay = dateOnly(today);
  }

  bool get _selectedDayIsMarked => _poopDays.contains(_selectedDay);

  int get _monthLogCount {
    return _poopDays
        .where(
          (DateTime day) =>
              day.year == _visibleMonth.year &&
              day.month == _visibleMonth.month,
        )
        .length;
  }

  void _goToPreviousMonth() {
    setState(() {
      _visibleMonth = DateTime(_visibleMonth.year, _visibleMonth.month - 1);
      _selectedDay = _clampSelectedDayToVisibleMonth();
    });
  }

  void _goToNextMonth() {
    setState(() {
      _visibleMonth = DateTime(_visibleMonth.year, _visibleMonth.month + 1);
      _selectedDay = _clampSelectedDayToVisibleMonth();
    });
  }

  void _selectDay(DateTime day) {
    setState(() {
      _selectedDay = dateOnly(day);
      _visibleMonth = DateTime(day.year, day.month);
    });
  }

  void _toggleSelectedDay() {
    setState(() {
      if (_selectedDayIsMarked) {
        _poopDays.remove(_selectedDay);
      } else {
        _poopDays.add(_selectedDay);
      }
    });
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
        child: Stack(
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
                    });
                  },
                ),
                const SizedBox(height: 18),
                CalendarSection(
                  visibleMonth: _visibleMonth,
                  selectedDay: _selectedDay,
                  poopDays: _poopDays,
                  onPreviousMonth: _goToPreviousMonth,
                  onNextMonth: _goToNextMonth,
                  onDaySelected: _selectDay,
                ),
                const SizedBox(height: 16),
                SelectedDayPanel(
                  day: _selectedDay,
                  isMarked: _selectedDayIsMarked,
                  monthLogCount: _monthLogCount,
                  onToggle: _toggleSelectedDay,
                ),
                const SizedBox(height: 16),
                const BristolSection(),
                const SizedBox(height: 12),
                const MoodSection(),
                const SizedBox(height: 12),
                const Row(
                  children: [
                    Expanded(
                      child: ProgressCard(
                        asset: AppAssets.hydrationDrop,
                        title: 'Hydration',
                        value: '6 / 8 cups',
                        progress: 0.75,
                        color: Color(0xFF22A9A4),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: ProgressCard(
                        asset: AppAssets.fiberLeaf,
                        title: 'Fiber',
                        value: '18 / 25 g',
                        progress: 0.72,
                        color: Color(0xFF3F8E2E),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                const NotesCard(),
              ],
            ),
            const Align(
              alignment: Alignment.bottomCenter,
              child: PoopBottomNavigation(),
            ),
          ],
        ),
      ),
    );
  }
}
