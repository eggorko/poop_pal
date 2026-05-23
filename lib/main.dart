import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(const PoopTrackerApp());
}

class PoopTrackerApp extends StatelessWidget {
  const PoopTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    const Color seed = Color(0xFF28A9A3);

    return MaterialApp(
      title: 'PoopPal',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: seed,
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFFFFDF8),
        useMaterial3: true,
        fontFamily: 'Roboto',
        cardTheme: const CardThemeData(
          color: Colors.white,
          elevation: 0,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(22)),
            side: BorderSide(color: Color(0xFFEDE8DF)),
          ),
        ),
      ),
      home: const PoopCalendarScreen(),
    );
  }
}

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
    _selectedDay = _dateOnly(today);
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
      _selectedDay = _dateOnly(day);
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
                _AppHeader(
                  onTodayPressed: () {
                    final DateTime today = DateTime.now();
                    setState(() {
                      _visibleMonth = DateTime(today.year, today.month);
                      _selectedDay = _dateOnly(today);
                    });
                  },
                ),
                const SizedBox(height: 18),
                _CalendarSection(
                  visibleMonth: _visibleMonth,
                  selectedDay: _selectedDay,
                  poopDays: _poopDays,
                  onPreviousMonth: _goToPreviousMonth,
                  onNextMonth: _goToNextMonth,
                  onDaySelected: _selectDay,
                ),
                const SizedBox(height: 16),
                _SelectedDayPanel(
                  day: _selectedDay,
                  isMarked: _selectedDayIsMarked,
                  monthLogCount: _monthLogCount,
                  onToggle: _toggleSelectedDay,
                ),
                const SizedBox(height: 16),
                const _BristolSection(),
                const SizedBox(height: 12),
                const _MoodSection(),
                const SizedBox(height: 12),
                const Row(
                  children: [
                    Expanded(
                      child: _ProgressCard(
                        asset: 'assets/vectors/hydration_drop.svg',
                        title: 'Hydration',
                        value: '6 / 8 cups',
                        progress: 0.75,
                        color: Color(0xFF22A9A4),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: _ProgressCard(
                        asset: 'assets/vectors/fiber_leaf.svg',
                        title: 'Fiber',
                        value: '18 / 25 g',
                        progress: 0.72,
                        color: Color(0xFF3F8E2E),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                const _NotesCard(),
              ],
            ),
            const Align(
              alignment: Alignment.bottomCenter,
              child: _PoopBottomNavigation(),
            ),
          ],
        ),
      ),
    );
  }
}

class _AppHeader extends StatelessWidget {
  const _AppHeader({required this.onTodayPressed});

  final VoidCallback onTodayPressed;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return SizedBox(
      height: 188,
      child: ClipPath(
        clipper: _HeaderClipper(),
        child: DecoratedBox(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFFDDF8F0), Color(0xFFBEEADF)],
            ),
          ),
          child: SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 22, 24, 44),
              child: Row(
                children: [
                  SvgPicture.asset(
                    'assets/vectors/poop_mascot.svg',
                    width: 70,
                    height: 70,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      'PoopPal',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.displaySmall?.copyWith(
                        color: const Color(0xFF084B52),
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0,
                      ),
                    ),
                  ),
                  IconButton.filledTonal(
                    tooltip: 'Today',
                    onPressed: onTodayPressed,
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.white.withValues(alpha: 0.76),
                      foregroundColor: const Color(0xFF149994),
                      fixedSize: const Size(58, 58),
                    ),
                    icon: SvgPicture.asset(
                      'assets/vectors/insights_bars.svg',
                      width: 30,
                      height: 30,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CalendarSection extends StatelessWidget {
  const _CalendarSection({
    required this.visibleMonth,
    required this.selectedDay,
    required this.poopDays,
    required this.onPreviousMonth,
    required this.onNextMonth,
    required this.onDaySelected,
  });

  final DateTime visibleMonth;
  final DateTime selectedDay;
  final Set<DateTime> poopDays;
  final VoidCallback onPreviousMonth;
  final VoidCallback onNextMonth;
  final ValueChanged<DateTime> onDaySelected;

  static const List<String> _weekdays = <String>[
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun',
  ];

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final List<DateTime> cells = _buildCalendarCells(visibleMonth);

    return Column(
      children: [
        Row(
          children: [
            _RoundIconButton(
              tooltip: 'Previous month',
              icon: Icons.chevron_left,
              onPressed: onPreviousMonth,
            ),
            Expanded(
              child: Text(
                _monthTitle(visibleMonth),
                textAlign: TextAlign.center,
                style: theme.textTheme.headlineSmall?.copyWith(
                  color: const Color(0xFF10272A),
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0,
                ),
              ),
            ),
            _RoundIconButton(
              tooltip: 'Next month',
              icon: Icons.chevron_right,
              onPressed: onNextMonth,
            ),
          ],
        ),
        const SizedBox(height: 18),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _weekdays.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            mainAxisExtent: 26,
          ),
          itemBuilder: (BuildContext context, int index) {
            return Center(
              child: Text(
                _weekdays[index],
                style: theme.textTheme.labelLarge?.copyWith(
                  color: const Color(0xFF101D21),
                  fontWeight: FontWeight.w600,
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 8),
        DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.72),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFEDE8DF)),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: cells.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
                mainAxisExtent: 58,
              ),
              itemBuilder: (BuildContext context, int index) {
                final DateTime day = cells[index];

                return _CalendarDayButton(
                  day: day,
                  isInVisibleMonth: day.month == visibleMonth.month,
                  isSelected: _isSameDay(day, selectedDay),
                  isToday: _isSameDay(day, DateTime.now()),
                  isMarked: poopDays.contains(_dateOnly(day)),
                  onPressed: () => onDaySelected(day),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class _CalendarDayButton extends StatelessWidget {
  const _CalendarDayButton({
    required this.day,
    required this.isInVisibleMonth,
    required this.isSelected,
    required this.isToday,
    required this.isMarked,
    required this.onPressed,
  });

  final DateTime day;
  final bool isInVisibleMonth;
  final bool isSelected;
  final bool isToday;
  final bool isMarked;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Color textColor = isInVisibleMonth
        ? const Color(0xFF101D21)
        : const Color(0xFFA8A5A0);

    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFEDE8DF), width: 0.5),
      ),
      child: Semantics(
        button: true,
        selected: isSelected,
        label:
            '${_monthTitle(day)} ${day.day}${isMarked ? ', poop logged' : ''}',
        child: InkWell(
          onTap: onPressed,
          child: Center(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 160),
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xFFD8F5EC)
                    : isToday
                    ? const Color(0xFFFFF5DF)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(10),
                border: isSelected
                    ? Border.all(color: const Color(0xFF28BDB6), width: 1.5)
                    : null,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${day.day}',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: textColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 2),
                  SizedBox(
                    height: 16,
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 150),
                      child: isMarked
                          ? SvgPicture.asset(
                              'assets/vectors/poop_marker.svg',
                              key: const ValueKey<String>('poop'),
                              width: 18,
                              height: 18,
                            )
                          : isInVisibleMonth && day.day % 4 == 0
                          ? const Icon(
                              Icons.circle,
                              key: ValueKey<String>('dot'),
                              size: 8,
                              color: Color(0xFF2AA9A4),
                            )
                          : const SizedBox.shrink(
                              key: ValueKey<String>('empty'),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SelectedDayPanel extends StatelessWidget {
  const _SelectedDayPanel({
    required this.day,
    required this.isMarked,
    required this.monthLogCount,
    required this.onToggle,
  });

  final DateTime day;
  final bool isMarked;
  final int monthLogCount;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Column(
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                _DateTile(day: day),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Today 🎉',
                        style: theme.textTheme.titleLarge?.copyWith(
                          color: const Color(0xFF10272A),
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Row(
                        children: [
                          Expanded(
                            child: _SelectedMetric(
                              label: 'Time',
                              value: '8:15 AM',
                            ),
                          ),
                          Expanded(
                            child: _SelectedMetric(
                              label: 'Feeling',
                              value: 'Good 🙂',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                SvgPicture.asset(
                  'assets/vectors/toilet_paper_mascot.svg',
                  width: 86,
                  height: 86,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: _StreakCard(monthLogCount: monthLogCount)),
            const SizedBox(width: 10),
            Expanded(
              child: FilledButton(
                onPressed: onToggle,
                style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xFFFF765F),
                  foregroundColor: Colors.white,
                  minimumSize: const Size.fromHeight(76),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      isMarked ? Icons.check_circle : Icons.add_circle,
                      size: 34,
                    ),
                    const SizedBox(width: 12),
                    Flexible(
                      child: Text(
                        isMarked ? 'Logged' : 'Log poop',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.titleLarge?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _DateTile extends StatelessWidget {
  const _DateTile({required this.day});

  final DateTime day;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Container(
      width: 102,
      height: 102,
      decoration: BoxDecoration(
        color: const Color(0xFFD8F5EC),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            _weekdayShort(day).toUpperCase(),
            style: theme.textTheme.labelLarge?.copyWith(
              color: const Color(0xFF10272A),
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            '${day.day}',
            style: theme.textTheme.headlineLarge?.copyWith(
              color: const Color(0xFF084B52),
              fontWeight: FontWeight.w900,
              letterSpacing: 0,
            ),
          ),
          Text(
            _shortMonthTitle(day),
            style: theme.textTheme.bodyMedium?.copyWith(
              color: const Color(0xFF10272A),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _SelectedMetric extends StatelessWidget {
  const _SelectedMetric({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: theme.textTheme.bodyLarge),
        Text(
          value,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: theme.textTheme.titleLarge?.copyWith(
            color: const Color(0xFF10272A),
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

class _StreakCard extends StatelessWidget {
  const _StreakCard({required this.monthLogCount});

  final int monthLogCount;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Card(
      color: const Color(0xFFFFFCF5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(color: Color(0xFFF4DDBB)),
      ),
      child: SizedBox(
        height: 76,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Row(
            children: [
              Text(
                'Streak',
                style: theme.textTheme.titleMedium?.copyWith(
                  color: const Color(0xFFA34E1D),
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(width: 12),
              SvgPicture.asset(
                'assets/vectors/streak_flame.svg',
                width: 38,
                height: 38,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  '$monthLogCount poop days',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: const Color(0xFFA34E1D),
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BristolSection extends StatelessWidget {
  const _BristolSection();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14, 14, 14, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Bristol',
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: const Color(0xFF10272A),
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(Icons.info, color: Color(0xFF28A9A3), size: 22),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 80,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: 7,
                separatorBuilder: (_, _) => const SizedBox(width: 8),
                itemBuilder: (BuildContext context, int index) {
                  final int type = index + 1;

                  return _BristolTypeButton(type: type, isSelected: type == 4);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BristolTypeButton extends StatelessWidget {
  const _BristolTypeButton({required this.type, required this.isSelected});

  final int type;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Container(
      width: 74,
      decoration: BoxDecoration(
        color: const Color(0xFFFFFEFB),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isSelected ? const Color(0xFF28BDB6) : const Color(0xFFEDE8DF),
          width: isSelected ? 2 : 1,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/vectors/bristol_type_$type.svg',
            width: 48,
            height: 32,
          ),
          const SizedBox(height: 4),
          Text(
            '$type',
            style: theme.textTheme.labelLarge?.copyWith(
              color: const Color(0xFF10272A),
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

class _MoodSection extends StatelessWidget {
  const _MoodSection();

  static const List<({String asset, String label})> _moods = [
    (asset: 'assets/vectors/mood_great.svg', label: 'Great'),
    (asset: 'assets/vectors/mood_good.svg', label: 'Good'),
    (asset: 'assets/vectors/mood_okay.svg', label: 'Okay'),
    (asset: 'assets/vectors/mood_not_great.svg', label: 'Not great'),
    (asset: 'assets/vectors/mood_bad.svg', label: 'Bad'),
  ];

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14, 14, 14, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Mood',
              style: theme.textTheme.titleLarge?.copyWith(
                color: const Color(0xFF10272A),
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                for (final mood in _moods)
                  Expanded(
                    child: _MoodButton(
                      asset: mood.asset,
                      label: mood.label,
                      isSelected: mood.label == 'Great',
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _MoodButton extends StatelessWidget {
  const _MoodButton({
    required this.asset,
    required this.label,
    required this.isSelected,
  });

  final String asset;
  final String label;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Column(
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: isSelected
                ? Border.all(color: const Color(0xFF28BDB6), width: 3)
                : null,
          ),
          child: Padding(
            padding: const EdgeInsets.all(3),
            child: SvgPicture.asset(asset, width: 48, height: 48),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: theme.textTheme.labelMedium?.copyWith(
            color: const Color(0xFF10272A),
            fontWeight: isSelected ? FontWeight.w800 : FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _ProgressCard extends StatelessWidget {
  const _ProgressCard({
    required this.asset,
    required this.title,
    required this.value,
    required this.progress,
    required this.color,
  });

  final String asset;
  final String title;
  final String value;
  final double progress;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SvgPicture.asset(asset, width: 28, height: 28),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: const Color(0xFF10272A),
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                value,
                style: theme.textTheme.titleMedium?.copyWith(
                  color: color,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            const SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(999),
              child: LinearProgressIndicator(
                minHeight: 10,
                value: progress,
                color: color,
                backgroundColor: const Color(0xFFE2ECE8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NotesCard extends StatelessWidget {
  const _NotesCard();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Card(
      child: ListTile(
        minVerticalPadding: 18,
        leading: SvgPicture.asset(
          'assets/vectors/notes_sheet.svg',
          width: 38,
          height: 38,
        ),
        title: Text(
          'Notes',
          style: theme.textTheme.titleMedium?.copyWith(
            color: const Color(0xFF10272A),
            fontWeight: FontWeight.w800,
          ),
        ),
        subtitle: const Text('Oatmeal for breakfast, big salad for lunch.'),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}

class _PoopBottomNavigation extends StatelessWidget {
  const _PoopBottomNavigation();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 0, 18, 16),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: const Color(0xFFFFFAF0).withValues(alpha: 0.96),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: SizedBox(
          height: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const _NavItem(
                icon: Icons.calendar_month,
                label: 'Calendar',
                selected: true,
              ),
              const _NavItem(
                icon: Icons.history,
                label: 'History',
                selected: false,
              ),
              Transform.translate(
                offset: const Offset(0, -18),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: const Color(0xFF49C2B8),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFFD8F5EC),
                      width: 5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.16),
                        blurRadius: 14,
                        offset: const Offset(0, 7),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(11),
                    child: SvgPicture.asset(
                      'assets/vectors/poop_mascot.svg',
                      width: 48,
                      height: 48,
                    ),
                  ),
                ),
              ),
              const _NavItem(
                icon: Icons.bar_chart,
                label: 'Insights',
                selected: false,
              ),
              const _NavItem(
                icon: Icons.person_outline,
                label: 'Profile',
                selected: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.label,
    required this.selected,
  });

  final IconData icon;
  final String label;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final Color color = selected
        ? const Color(0xFF119A95)
        : const Color(0xFF6F716E);
    final TextTheme textTheme = Theme.of(context).textTheme;

    return SizedBox(
      width: 62,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 4),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: textTheme.labelSmall?.copyWith(
              color: color,
              fontWeight: selected ? FontWeight.w800 : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _RoundIconButton extends StatelessWidget {
  const _RoundIconButton({
    required this.tooltip,
    required this.icon,
    required this.onPressed,
  });

  final String tooltip;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton.filledTonal(
      tooltip: tooltip,
      onPressed: onPressed,
      style: IconButton.styleFrom(
        backgroundColor: const Color(0xFFE8F7F4),
        foregroundColor: const Color(0xFF084B52),
        fixedSize: const Size(52, 52),
      ),
      icon: Icon(icon, size: 32),
    );
  }
}

class _HeaderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path()
      ..lineTo(0, size.height - 45)
      ..quadraticBezierTo(
        size.width * 0.5,
        size.height + 18,
        size.width,
        size.height - 45,
      )
      ..lineTo(size.width, 0)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

List<DateTime> _buildCalendarCells(DateTime visibleMonth) {
  final DateTime firstDay = DateTime(visibleMonth.year, visibleMonth.month);
  final int leadingDays = firstDay.weekday - DateTime.monday;
  final DateTime gridStart = firstDay.subtract(Duration(days: leadingDays));

  return <DateTime>[
    for (int index = 0; index < 42; index++)
      DateTime(gridStart.year, gridStart.month, gridStart.day + index),
  ];
}

DateTime _dateOnly(DateTime date) => DateTime(date.year, date.month, date.day);

bool _isSameDay(DateTime first, DateTime second) {
  return first.year == second.year &&
      first.month == second.month &&
      first.day == second.day;
}

String _monthTitle(DateTime date) {
  const List<String> months = <String>[
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  return '${months[date.month - 1]} ${date.year}';
}

String _shortMonthTitle(DateTime date) {
  const List<String> months = <String>[
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];

  return '${months[date.month - 1]} ${date.year}';
}

String _weekdayShort(DateTime date) {
  const List<String> weekdays = <String>[
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun',
  ];

  return weekdays[date.weekday - 1];
}
