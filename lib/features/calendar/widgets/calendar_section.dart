import 'package:flutter/material.dart';

import '../../../shared/date_helpers.dart';
import 'calendar_day_button.dart';
import 'round_icon_button.dart';

class CalendarSection extends StatelessWidget {
  const CalendarSection({
    required this.visibleMonth,
    required this.selectedDay,
    required this.poopDays,
    required this.onPreviousMonth,
    required this.onNextMonth,
    required this.onTodayPressed,
    required this.onDaySelected,
    super.key,
  });

  final DateTime visibleMonth;
  final DateTime selectedDay;
  final Set<DateTime> poopDays;
  final VoidCallback onPreviousMonth;
  final VoidCallback onNextMonth;
  final VoidCallback onTodayPressed;
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
    final List<DateTime> cells = buildCalendarCells(visibleMonth);

    return Column(
      children: [
        Row(
          children: [
            RoundIconButton(
              tooltip: 'Previous month',
              icon: Icons.chevron_left,
              onPressed: onPreviousMonth,
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Text(
                      monthTitle(visibleMonth),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.headlineSmall?.copyWith(
                        color: const Color(0xFF10272A),
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  TextButton(
                    onPressed: onTodayPressed,
                    style: TextButton.styleFrom(
                      foregroundColor: const Color(0xFF119A95),
                      minimumSize: const Size(58, 38),
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      textStyle: theme.textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    child: const Text('Today'),
                  ),
                ],
              ),
            ),
            RoundIconButton(
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

                return CalendarDayButton(
                  day: day,
                  isInVisibleMonth: day.month == visibleMonth.month,
                  isSelected: isSameDay(day, selectedDay),
                  isToday: isSameDay(day, DateTime.now()),
                  isMarked: poopDays.contains(dateOnly(day)),
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
