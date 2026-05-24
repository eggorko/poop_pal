import 'package:flutter/material.dart';

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
    final Color textColor = isMarked
        ? Colors.white
        : isInVisibleMonth
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
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 160),
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: isSelected
                      ? const Color(0xFFD8F5EC)
                      : isToday
                      ? const Color(0xFFFFF5DF)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                  border: isSelected
                      ? Border.all(
                          color: isMarked
                              ? Colors.white
                              : const Color(0xFF28BDB6),
                          width: 1.5,
                        )
                      : null,
                ),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    if (isMarked)
                      Image.asset(AppAssets.poopPal, fit: BoxFit.cover),
                    Align(
                      alignment: isMarked
                          ? Alignment.topCenter
                          : Alignment.center,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: isMarked
                              ? Colors.black.withValues(alpha: 0.48)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: isMarked ? 7 : 0,
                            vertical: isMarked ? 3 : 0,
                          ),
                          child: Text(
                            '${day.day}',
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: textColor,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
