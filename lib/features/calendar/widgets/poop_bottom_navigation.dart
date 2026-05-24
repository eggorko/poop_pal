import 'package:flutter/material.dart';

import '../../../app/feature_flags.dart';
import '../../../shared/app_assets.dart';

class PoopBottomNavigation extends StatelessWidget {
  const PoopBottomNavigation({
    required this.onLogPressed,
    required this.isLogged,
    required this.isFutureDate,
    required this.featureFlags,
    super.key,
  });

  final VoidCallback? onLogPressed;
  final bool isLogged;
  final bool isFutureDate;
  final FeatureFlags featureFlags;

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
            children: [
              Expanded(
                child: NavItemGroup(
                  children: [
                    if (featureFlags.calendar)
                      const NavItem(
                        icon: Icons.calendar_month,
                        label: 'Calendar',
                        selected: true,
                      ),
                    if (featureFlags.history)
                      const NavItem(
                        icon: Icons.history,
                        label: 'History',
                        selected: false,
                      ),
                  ],
                ),
              ),
              SizedBox(
                width: 96,
                child: OverflowBox(
                  minWidth: 100,
                  maxWidth: 100,
                  minHeight: 100,
                  maxHeight: 100,
                  alignment: Alignment.center,
                  child: Transform.translate(
                    offset: const Offset(0, 0),
                    child: CenterLogButton(
                      onPressed: onLogPressed,
                      isLogged: isLogged,
                      isFutureDate: isFutureDate,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: NavItemGroup(
                  children: [
                    if (featureFlags.insights)
                      const NavItem(
                        icon: Icons.bar_chart,
                        label: 'Insights',
                        selected: false,
                      ),
                    if (featureFlags.profile)
                      const NavItem(
                        icon: Icons.person_outline,
                        label: 'Profile',
                        selected: false,
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CenterLogButton extends StatelessWidget {
  const CenterLogButton({
    required this.onPressed,
    required this.isLogged,
    required this.isFutureDate,
    super.key,
  });

  final VoidCallback? onPressed;
  final bool isLogged;
  final bool isFutureDate;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: isFutureDate
          ? 'Cannot log a future date'
          : isLogged
          ? 'Poop already logged'
          : 'Log poop',
      child: Tooltip(
        message: isFutureDate
            ? 'Cannot log a future date'
            : isLogged
            ? 'Poop already logged'
            : 'Log poop',
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Material(
              color: isFutureDate
                  ? const Color(0xFF9AA4A3)
                  : const Color(0xFF49C2B8),
              shape: const CircleBorder(),
              elevation: 8,
              shadowColor: Colors.black26,
              child: InkWell(
                customBorder: const CircleBorder(),
                onTap: onPressed,
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFFD8F5EC),
                      width: 6,
                    ),
                  ),
                  padding: const EdgeInsets.all(8),
                  child: Image.asset(AppAssets.poopPal, fit: BoxFit.contain),
                ),
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: isLogged
                      ? const Color(0xFF2F9D5B)
                      : isFutureDate
                      ? const Color(0xFF737B7A)
                      : const Color(0xFFFF765F),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 3),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.16),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: SizedBox(
                  width: 40,
                  height: 40,
                  child: Icon(
                    isLogged ? Icons.check : Icons.add,
                    color: Colors.white,
                    size: 26,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NavItemGroup extends StatelessWidget {
  const NavItemGroup({required this.children, super.key});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: children,
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
