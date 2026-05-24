import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../shared/app_assets.dart';

class NotesCard extends StatelessWidget {
  const NotesCard({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Card(
      child: ListTile(
        minVerticalPadding: 18,
        leading: SvgPicture.asset(AppAssets.notesSheet, width: 38, height: 38),
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
