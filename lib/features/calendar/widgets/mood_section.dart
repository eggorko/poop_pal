import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../shared/app_assets.dart';

class MoodSection extends StatelessWidget {
  const MoodSection({super.key});

  static const List<({String asset, String label})> _moods = [
    (asset: AppAssets.moodGreat, label: 'Great'),
    (asset: AppAssets.moodGood, label: 'Good'),
    (asset: AppAssets.moodOkay, label: 'Okay'),
    (asset: AppAssets.moodNotGreat, label: 'Not great'),
    (asset: AppAssets.moodBad, label: 'Bad'),
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
              'After Poop Mood',
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
                    child: MoodButton(
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

class MoodButton extends StatelessWidget {
  const MoodButton({
    required this.asset,
    required this.label,
    required this.isSelected,
    super.key,
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
