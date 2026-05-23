import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../shared/app_assets.dart';
import '../../../shared/date_helpers.dart';

class CalendarDayButton extends StatelessWidget {
  const CalendarDayButton({
    required this.day,
    required this.isInVisibleMonth,
    required this.isSelected,
    required this.isToday,
    required this.isMarked,
    required this.onPressed,
    super.key,
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
            '${monthTitle(day)} ${day.day}${isMarked ? ', poop logged' : ''}',
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
                              AppAssets.poopMarker,
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
