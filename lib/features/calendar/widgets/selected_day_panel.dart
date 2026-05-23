import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../shared/app_assets.dart';
import '../../../shared/date_helpers.dart';

class SelectedDayPanel extends StatelessWidget {
  const SelectedDayPanel({
    required this.day,
    required this.isMarked,
    required this.monthLogCount,
    required this.onToggle,
    super.key,
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
                DateTile(day: day),
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
                            child: SelectedMetric(
                              label: 'Time',
                              value: '8:15 AM',
                            ),
                          ),
                          Expanded(
                            child: SelectedMetric(
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
                  AppAssets.toiletPaperMascot,
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
            Expanded(child: StreakCard(monthLogCount: monthLogCount)),
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

class DateTile extends StatelessWidget {
  const DateTile({required this.day, super.key});

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
            weekdayShort(day).toUpperCase(),
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
            shortMonthTitle(day),
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

class SelectedMetric extends StatelessWidget {
  const SelectedMetric({required this.label, required this.value, super.key});

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

class StreakCard extends StatelessWidget {
  const StreakCard({required this.monthLogCount, super.key});

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
              SvgPicture.asset(AppAssets.streakFlame, width: 38, height: 38),
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
