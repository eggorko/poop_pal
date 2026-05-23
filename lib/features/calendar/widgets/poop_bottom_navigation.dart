import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../shared/app_assets.dart';

class PoopBottomNavigation extends StatelessWidget {
  const PoopBottomNavigation({super.key});

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
              const NavItem(
                icon: Icons.calendar_month,
                label: 'Calendar',
                selected: true,
              ),
              const NavItem(
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
                      AppAssets.poopMascot,
                      width: 48,
                      height: 48,
                    ),
                  ),
                ),
              ),
              const NavItem(
                icon: Icons.bar_chart,
                label: 'Insights',
                selected: false,
              ),
              const NavItem(
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

class NavItem extends StatelessWidget {
  const NavItem({
    required this.icon,
    required this.label,
    required this.selected,
    super.key,
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
