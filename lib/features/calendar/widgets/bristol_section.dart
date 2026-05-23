import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../shared/app_assets.dart';

class BristolSection extends StatelessWidget {
  const BristolSection({super.key});

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

                  return BristolTypeButton(type: type, isSelected: type == 4);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BristolTypeButton extends StatelessWidget {
  const BristolTypeButton({
    required this.type,
    required this.isSelected,
    super.key,
  });

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
          SvgPicture.asset(AppAssets.bristolType(type), width: 48, height: 32),
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
