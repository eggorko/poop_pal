import 'package:flutter/material.dart';

void main() {
  runApp(const PoopTrackerApp());
}

class PoopTrackerApp extends StatelessWidget {
  const PoopTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PoopPal',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2E7D64),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
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
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('PoopPal'),
        actions: [
          IconButton(
            tooltip: 'Today',
            onPressed: () {
              final DateTime today = DateTime.now();
              setState(() {
                _visibleMonth = DateTime(today.year, today.month);
                _selectedDay = _dateOnly(today);
              });
            },
            icon: const Icon(Icons.today_outlined),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _SummaryCard(
              monthLogCount: _monthLogCount,
              totalLogCount: _poopDays.length,
            ),
            const SizedBox(height: 16),
            _CalendarCard(
              visibleMonth: _visibleMonth,
              selectedDay: _selectedDay,
              poopDays: _poopDays,
              onPreviousMonth: _goToPreviousMonth,
              onNextMonth: _goToNextMonth,
              onDaySelected: _selectDay,
            ),
            const SizedBox(height: 16),
            _SelectedDayCard(
              day: _selectedDay,
              isMarked: _selectedDayIsMarked,
              onToggle: _toggleSelectedDay,
            ),
            const SizedBox(height: 16),
            Text('Coming next', style: theme.textTheme.titleMedium),
            const SizedBox(height: 8),
            const _PlaceholderFeatureGrid(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _toggleSelectedDay,
        icon: Icon(_selectedDayIsMarked ? Icons.check : Icons.add),
        label: Text(_selectedDayIsMarked ? 'Logged' : 'Log poop'),
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({
    required this.monthLogCount,
    required this.totalLogCount,
  });

  final int monthLogCount;
  final int totalLogCount;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: theme.colorScheme.primaryContainer,
              foregroundColor: theme.colorScheme.onPrimaryContainer,
              child: const Icon(Icons.wc_outlined),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('This month', style: theme.textTheme.labelLarge),
                  Text(
                    '$monthLogCount poop days',
                    style: theme.textTheme.headlineSmall,
                  ),
                ],
              ),
            ),
            _StatPill(label: 'Total', value: '$totalLogCount'),
          ],
        ),
      ),
    );
  }
}

class _CalendarCard extends StatelessWidget {
  const _CalendarCard({
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
    final List<DateTime?> cells = _buildCalendarCells(visibleMonth);

    return Card(
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 8, 12, 16),
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  tooltip: 'Previous month',
                  onPressed: onPreviousMonth,
                  icon: const Icon(Icons.chevron_left),
                ),
                Expanded(
                  child: Text(
                    _monthTitle(visibleMonth),
                    textAlign: TextAlign.center,
                    style: theme.textTheme.titleLarge,
                  ),
                ),
                IconButton(
                  tooltip: 'Next month',
                  onPressed: onNextMonth,
                  icon: const Icon(Icons.chevron_right),
                ),
              ],
            ),
            const SizedBox(height: 8),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 7,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
                mainAxisExtent: 28,
              ),
              itemBuilder: (BuildContext context, int index) {
                return Center(
                  child: Text(
                    _weekdays[index],
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 4),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: cells.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
                mainAxisExtent: 48,
              ),
              itemBuilder: (BuildContext context, int index) {
                final DateTime? day = cells[index];
                if (day == null) {
                  return const SizedBox.shrink();
                }

                return _CalendarDayButton(
                  day: day,
                  isSelected: _isSameDay(day, selectedDay),
                  isToday: _isSameDay(day, DateTime.now()),
                  isMarked: poopDays.contains(_dateOnly(day)),
                  onPressed: () => onDaySelected(day),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _CalendarDayButton extends StatelessWidget {
  const _CalendarDayButton({
    required this.day,
    required this.isSelected,
    required this.isToday,
    required this.isMarked,
    required this.onPressed,
  });

  final DateTime day;
  final bool isSelected;
  final bool isToday;
  final bool isMarked;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colors = theme.colorScheme;

    final Color backgroundColor = isSelected
        ? colors.primary
        : isToday
        ? colors.primaryContainer
        : Colors.transparent;
    final Color foregroundColor = isSelected
        ? colors.onPrimary
        : isToday
        ? colors.onPrimaryContainer
        : colors.onSurface;

    return Padding(
      padding: const EdgeInsets.all(3),
      child: Semantics(
        button: true,
        selected: isSelected,
        label:
            '${_monthTitle(day)} ${day.day}${isMarked ? ', poop logged' : ''}',
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: onPressed,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: isSelected ? colors.primary : colors.outlineVariant,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${day.day}',
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: foregroundColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 150),
                  opacity: isMarked ? 1 : 0,
                  child: Icon(
                    Icons.circle,
                    size: 7,
                    color: isSelected
                        ? colors.onPrimary
                        : const Color(0xFF8D5A3B),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SelectedDayCard extends StatelessWidget {
  const _SelectedDayCard({
    required this.day,
    required this.isMarked,
    required this.onToggle,
  });

  final DateTime day;
  final bool isMarked;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Selected day', style: theme.textTheme.labelLarge),
                      Text(_fullDate(day), style: theme.textTheme.titleLarge),
                    ],
                  ),
                ),
                Icon(
                  isMarked ? Icons.check_circle : Icons.radio_button_unchecked,
                  color: isMarked
                      ? theme.colorScheme.primary
                      : theme.colorScheme.outline,
                ),
              ],
            ),
            const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: onToggle,
              icon: Icon(isMarked ? Icons.undo : Icons.add),
              label: Text(isMarked ? 'Remove poop log' : 'Mark poop day'),
            ),
          ],
        ),
      ),
    );
  }
}

class _PlaceholderFeatureGrid extends StatelessWidget {
  const _PlaceholderFeatureGrid();

  @override
  Widget build(BuildContext context) {
    return const Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        _FeatureChip(icon: Icons.mood_outlined, label: 'Mood'),
        _FeatureChip(icon: Icons.water_drop_outlined, label: 'Hydration'),
        _FeatureChip(icon: Icons.grass_outlined, label: 'Fiber'),
        _FeatureChip(icon: Icons.notes_outlined, label: 'Notes'),
      ],
    );
  }
}

class _FeatureChip extends StatelessWidget {
  const _FeatureChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      avatar: Icon(icon),
      label: Text(label),
      onPressed: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$label tracking is coming soon.')),
        );
      },
    );
  }
}

class _StatPill extends StatelessWidget {
  const _StatPill({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: theme.colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        child: Column(
          children: [
            Text(
              label,
              style: theme.textTheme.labelSmall?.copyWith(
                color: theme.colorScheme.onSecondaryContainer,
              ),
            ),
            Text(
              value,
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.onSecondaryContainer,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

List<DateTime?> _buildCalendarCells(DateTime visibleMonth) {
  final DateTime firstDay = DateTime(visibleMonth.year, visibleMonth.month);
  final int daysInMonth = DateTime(
    visibleMonth.year,
    visibleMonth.month + 1,
    0,
  ).day;
  final int leadingEmptyCells = firstDay.weekday - DateTime.monday;

  return <DateTime?>[
    for (int index = 0; index < leadingEmptyCells; index++) null,
    for (int day = 1; day <= daysInMonth; day++)
      DateTime(visibleMonth.year, visibleMonth.month, day),
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

String _fullDate(DateTime date) {
  const List<String> weekdays = <String>[
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];

  return '${weekdays[date.weekday - 1]}, ${_monthTitle(date)} ${date.day}';
}
